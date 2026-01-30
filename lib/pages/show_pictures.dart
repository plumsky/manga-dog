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

  final GlobalKey<ControllableAutoHideWidgetState> _widgetKeyPage = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height / 5;
    final width = MediaQuery.of(context).size.width / 2;

    final selectedIndex = useState(0);
    final scrollIndex = useState(0);
    final visible = useState(true);

    useEffect(() {
      _controller.addListener(() {
        final current =
            (_controller.position.pixels * imagePaths.length) ~/
            _controller.position.maxScrollExtent;
        if (current != selectedIndex.value) {
          scrollIndex.value = current;
        }
      });
      return null;
    }, []);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: _buildViewerWidget(selectedIndex, visible)
          ),
          Visibility(
            visible: visible.value,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: height,
                child: Column(
                  children: [
                    Row(children: [
                      Spacer(),
                      Text(
                        '${scrollIndex.value + 1}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: scrollIndex.value / (imagePaths.length - 1),
                          color: Colors.white,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        '${imagePaths.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Spacer()
                    ]),
                    SizedBox(height: 8),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          _buildImagesListWidget(selectedIndex, height, width),
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
                        ],
                      ),
                    ),
                  ],
                ),
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
  
  void _onScaleChangedEvent(PhotoViewScaleState scale, ValueNotifier<bool> visible) {
    AppLogger.debug('Scale changed: $scale');
    visible.value = (scale == PhotoViewScaleState.initial);
  }

  Widget _buildViewerWidget(ValueNotifier<int> selectedIndex, ValueNotifier<bool> visible) {
    return Stack(
      alignment: AlignmentGeometry.topCenter,
      children: [
        zip == null
            ? PhotoView(
          scaleStateChangedCallback: (scale) {
            _onScaleChangedEvent(scale, visible);
          },
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
        Positioned(
          top: 40,
          child: IgnorePointer(
            ignoring: true,
            child: ControllableAutoHideWidget(
              key: _widgetKeyPage,
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
        )
      ],
    );
  }

  Widget _buildImagesListWidget(ValueNotifier<int> selectedIndex, double height, double width) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      padding: EdgeInsets.symmetric(horizontal: width),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            selectedIndex.value = index;
            _widgetKeyPage.currentState?.show();
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
    );
  }
}
