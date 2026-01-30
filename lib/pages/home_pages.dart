import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manga_dog/models/objectbox_models.dart';
import 'package:manga_dog/utils/app_logger.dart';
import 'package:manga_dog/utils/files_sort_helper.dart';
import 'package:manga_dog/utils/zip_image_cache_manager.dart';
import 'package:manga_dog/widgets/reflected_widget.dart';

import '../core/objectbox_database.dart';
import '../generated/l10n.dart';
import '../utils/file_system_utils.dart';
import '../widgets/rounded_image.dart';
import 'show_pictures.dart';

class HomePages extends ConsumerWidget {
  HomePages({super.key});

  late final ObjectBoxDatabase? _db;
  late final DatabaseStats? _stats;
  late final List<Manga>? _mangas;
  late final List<Manga>? _recentMangas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Manga dog', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(),
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: S.current.what_to_do,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onSubmitted: (value) async {
                    final type = await FileSystemUtils.getPathType(value);
                    switch (type) {
                      case FileSystemEntityType.directory:
                        _openPathToRead(context, ref, path: value);
                        break;
                      case FileSystemEntityType.file:
                        _openZipToRead(context, filePath: value);
                        break;
                      default:
                        AppLogger.warning('Invalid path: $value');
                        break;
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  _openZipToRead(context);
                },
                icon: Icon(Icons.file_open, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  _openPathToRead(context, ref);
                },
                icon: Icon(Icons.drive_file_move_rounded, color: Colors.white),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 20),
          Expanded(child: _buildRecentAndLibrarySection()),
        ],
      ),
    );
  }

  Widget _buildRecentAndLibrarySection() {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _initDateBase(),
        builder: (context, data) {
          if (data.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '⏰ ${S.current.recent_read} (${_stats?.mangaCount})',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ReflectedWidget(child: RoundedImage(
                      imageFile: File(_recentMangas?[index].coverPath ?? ''),
                      height: 100,
                    ));
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: _recentMangas?.length ?? 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _initDateBase() async {
    try {
      _db = await ObjectBoxDatabase.getInstance();
      _stats = await _db!.getStats();
      _mangas = _db.mangaBox.getAll();
      _recentMangas = await _db.getRecentlyOpenedManga();
    } catch (e) {
      AppLogger.error('Failed to initialize database: $e');
      _db = null;
      _stats = null;
      _mangas = null;
      _recentMangas = null;
    }
  }

  Future<void> _openZipToRead(BuildContext context, {String? filePath}) async {
    FilePickerResult? result = filePath == null
        ? await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: [
              'zip',
              'tgz',
              'tbz',
              'tar',
              'gz',
              'gzip',
              'bz2',
              'bzip2',
            ],
          )
        : null;
    if (result == null && filePath == null) {
      // User canceled the picker
      AppLogger.warning('File picking canceled');
      return;
    }

    final zipPaths = result?.paths;
    if (zipPaths == null && filePath == null) {
      AppLogger.warning('No file selected');
      return;
    }
    final resultPath = filePath ?? (zipPaths?.first ?? '');
    final zip = ZipImageCacheManager(resultPath);
    await zip.initialize();
    final imagePaths = zip.getImageFileNames();
    final sortedFs = FilesSortHelper.sortFilesByName(imagePaths);

    if (!context.mounted) {
      return;
    }

    final title = resultPath
        .split(Platform.pathSeparator)
        .last
        .split('.')
        .first;
    _db?.addOrUpdateMangaByPath(
      path: resultPath,
      title: title,
      totalPages: sortedFs.length,
      coverPath: sortedFs.isNotEmpty ? sortedFs.first : '',
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowPictures(imagePaths: sortedFs, zip: zip),
      ),
    );
  }

  Future<void> _openPathToRead(
    BuildContext context,
    WidgetRef ref, {
    String? path,
  }) async {
    String? result = path ?? await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      FileSystemUtils.getFilesInDirectory(result).then((files) {
        final fs = files.whereType<File>().toList();
        final sortedFs = FilesSortHelper.sortFiles(fs);
        if (!context.mounted) {
          return;
        }

        final title = result.split(Platform.pathSeparator).last;
        _db?.addOrUpdateMangaByPath(
          path: result,
          title: title,
          totalPages: sortedFs.length,
          coverPath: sortedFs.isNotEmpty ? sortedFs.first.path : '',
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShowPictures(imagePaths: sortedFs.map((e) => e.path).toList()),
          ),
        );
      });
    } else {
      // User canceled the picker
      AppLogger.warning('Path picking canceled');
    }
  }
}
