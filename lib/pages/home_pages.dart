import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manga_dog/utils/app_logger.dart';
import 'package:manga_dog/utils/files_sort_helper.dart';
import 'package:manga_dog/utils/zip_image_cache_manager.dart';
import 'package:manga_dog/widgets/loading_widget.dart';
import 'package:manga_dog/widgets/reflected_widget.dart';

import '../generated/l10n.dart';
import '../providers/objectbox_database.dart';
import '../utils/file_system_utils.dart';
import '../widgets/rounded_image.dart';
import 'show_pictures.dart';

class HomePages extends ConsumerWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseAsync = ref.watch(objectBoxDatabaseProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Manga dog', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTopActions(context, ref),
          SizedBox(height: 20),
          Expanded(
            child: databaseAsync.when(
              loading: () =>
                  Center(child: LoadingWidget(width: 300, height: 300)),
              error: (error, stack) => Center(
                child: Text(
                  'init data failed: $error',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              data: (_) => _buildRecentAndLibrarySection(ref),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTopActions(BuildContext context, WidgetRef ref) {
    return Row(
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
                  _openZipToRead(context, ref, filePath: value);
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
            _openZipToRead(context, ref);
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
    );
  }

  Widget _buildRecentAndLibrarySection(WidgetRef ref) {
    final recentMangasAsync = ref.watch(recentManagerProvider);
    final statsAsync = ref.watch(databaseStatsProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: statsAsync.when(
              loading: () => Text(
                '⏰ ${S.current.recent_read} (...)',
                style: TextStyle(color: Colors.white),
              ),
              error: (error, stack) => Text(
                '⏰ ${S.current.recent_read} (error)',
                style: TextStyle(color: Colors.white),
              ),
              data: (stats) => Text(
                '⏰ ${S.current.recent_read} (${stats.mangaCount})',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          recentMangasAsync.when(
            data: (recentMangas) => SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ReflectedWidget(
                    child: RoundedImage(
                      imageFile: File(recentMangas[index].coverPath ?? ''),
                      height: 100,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: recentMangas.length,
              ),
            ),
            error: (error, stack) =>
                Text('error', style: TextStyle(color: Colors.red)),
            loading: () =>
                Center(child: LoadingWidget()),
          ),
        ],
      ),
    );
  }

  Future<void> _openZipToRead(BuildContext context, WidgetRef ref, {String? filePath}) async {
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

    final db = await ref.watch(objectBoxDatabaseProvider.future);
    final title = resultPath
        .split(Platform.pathSeparator)
        .last
        .split('.')
        .first;
    db.addOrUpdateMangaByPath(
      path: resultPath,
      title: title,
      totalPages: sortedFs.length,
      coverPath: sortedFs.isNotEmpty ? sortedFs.first : '',
    );

    if (!context.mounted) {
      return;
    }
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
      FileSystemUtils.getFilesInDirectory(result).then((files) async {
        final fs = files.whereType<File>().toList();
        final sortedFs = FilesSortHelper.sortFiles(fs);

        final title = result.split(Platform.pathSeparator).last;
        final db = await ref.watch(objectBoxDatabaseProvider.future);
        db.addOrUpdateMangaByPath(
          path: result,
          title: title,
          totalPages: sortedFs.length,
          coverPath: sortedFs.isNotEmpty ? sortedFs.first.path : '',
        );

        if (!context.mounted) {
          return;
        }

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
