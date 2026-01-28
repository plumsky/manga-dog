import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manga_dog/utils/app_logger.dart';
import 'package:manga_dog/utils/zip_image_cache_manager.dart';
import 'package:photo_view/photo_view.dart';

import '../widgets/auto_hide_widget.dart';
import '../widgets/rounded_image.dart';

class ShowPictures extends HookConsumerWidget {
  ShowPictures({super.key, required this.imagePaths, this.zip});

  final List<String> imagePaths;
  final ZipImageCacheManager? zip;
  final ScrollController _controller = ScrollController();

  final GlobalKey<ControllableAutoHideWidgetState> _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height / 5;
    final width = MediaQuery.of(context).size.width / 2;

    final selectedIndex = useState(0);

    useEffect(() {
      _controller.addListener(() {
        // final current =
        //     (_controller.position.pixels * imagePaths.length) ~/
        //     _controller.position.maxScrollExtent;
        // AppLogger.debug(
        //   'Scroll position: ${_controller.position.pixels}, max: ${_controller.position.maxScrollExtent}, current index: $current',
        // );
        // if (current != selectedIndex.value) {
        //   selectedIndex.value = current;
        // }
        _widgetKey.currentState?.show();
      });
      return null;
    }, []);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: zip == null
                ? PhotoView(
                    scaleStateChangedCallback: _onScaleChangedEvent,
                    imageProvider: FileImage(
                      File(imagePaths[selectedIndex.value]),
                    ),
                  )
                : FutureBuilder(
                    future: zip!.getImageData(imagePaths[selectedIndex.value]),
                    builder: (context, data) {
                      return data.connectionState == ConnectionState.done &&
                              data.hasData
                          ? PhotoView(imageProvider: MemoryImage(data.data!))
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: height,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    padding: EdgeInsets.symmetric(horizontal: width),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          selectedIndex.value = index;
                        },
                        child: zip == null
                            ? RoundedImage(
                                imageFile: File(imagePaths[index]),
                                height: height,
                              )
                            : _buildZipThumbnail(imagePaths[index], height),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 8);
                    },
                    itemCount: imagePaths.length,
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(230),
                            Colors.transparent,
                            Colors.black.withAlpha(230),
                          ],
                          stops: [0.1, 0.5, 0.9],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: ControllableAutoHideWidget(
                      key: _widgetKey,
                      delay: Duration(seconds: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.black87,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${selectedIndex.value + 1} / ${imagePaths.length}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(CupertinoIcons.back),
      ),
    );
  }

  Widget _buildZipThumbnail(String path, double height) {
    final cacheImage = zip!.getCachedImage(path);
    if (cacheImage != null) {
      return RoundedImage(imageBytes: cacheImage, height: height);
    }
    return FutureBuilder(
      future: zip!.getImageData(path),
      builder: (context, data) {
        if (data.connectionState == ConnectionState.done && data.hasData) {
          return RoundedImage(imageBytes: data.data, height: height);
        } else {
          return RoundedImage(
            height: height,
            placeholder: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
  
  void _onScaleChangedEvent(PhotoViewScaleState scale) {
    AppLogger.debug('Scale changed: $scale');
  }
}
