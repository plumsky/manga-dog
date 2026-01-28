import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manga_dog/utils/app_logger.dart';
import 'package:manga_dog/utils/files_sort_helper.dart';
import 'package:manga_dog/utils/zip_image_cache_manager.dart';

import '../generated/l10n.dart';
import '../utils/file_system_utils.dart';
import 'show_pictures.dart';

class HomePages extends ConsumerWidget {
  const HomePages({super.key});

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
                        _openPathToRead(context, path: value);
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
                  _openPathToRead(context);
                },
                icon: Icon(Icons.drive_file_move_rounded, color: Colors.white),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openZipToRead(BuildContext context, {String? filePath}) async {
    FilePickerResult? result = filePath == null ? await FilePicker.pickFiles(
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
    ): null;
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
    final zip = ZipImageCacheManager(filePath ?? (zipPaths?.first ?? ''));
    await zip.initialize();
    final imagePaths = zip.getImageFileNames();
    final sortedFs = FilesSortHelper.sortFilesByName(
      imagePaths,
    );

    if (!context.mounted) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowPictures(
          imagePaths: sortedFs,
          zip: zip,
        ),
      ),
    );
  }

  Future<void> _openPathToRead(BuildContext context, {String? path}) async {
    String? result = path ?? await FilePicker.getDirectoryPath();
    if (result != null) {
      FileSystemUtils.getFilesInDirectory(result).then((files) {
        final fs = files.whereType<File>().toList();
        final sortedFs = FilesSortHelper.sortFiles(fs);
        if (!context.mounted) {
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowPictures(
              imagePaths: sortedFs.map((e) => e.path).toList(),
            ),
          ),
        );
      });
    } else {
      // User canceled the picker
      AppLogger.warning('Path picking canceled');
    }
  }
}
