import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final File? imageFile;
  final Uint8List? imageBytes;
  final double? width;
  final double? height;
  final double borderRadius;
  final BorderRadius? customBorderRadius;
  final BoxFit fit;
  final Color? backgroundColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  final List<BoxShadow>? shadows;
  final BoxBorder? border;
  final bool isCircular;

  const RoundedImage({super.key,
    this.imageUrl,
    this.assetPath,
    this.imageFile,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.customBorderRadius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.errorWidget,
    this.shadows,
    this.border,
    this.isCircular = false, this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadiusValue = isCircular
        ? BorderRadius.circular(width ?? 100)
        : customBorderRadius ?? BorderRadius.circular(borderRadius);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadiusValue,
        color: backgroundColor ?? Colors.grey[200],
        boxShadow: shadows,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: borderRadiusValue,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imageFile != null) {
      return _buildFileImage();
    } else if (imageBytes != null) {
      return _buildMemoryImage();
    } else if (imageUrl != null) {
      return _buildNetworkImage();
    } else if (assetPath != null) {
      return _buildAssetImage();
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildNetworkImage() {
    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? _buildDefaultPlaceholder();
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildDefaultErrorWidget();
      },
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      assetPath!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildDefaultErrorWidget();
      },
    );
  }

  Widget _buildFileImage() {
    return Image.file(
      imageFile!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildDefaultErrorWidget();
      },
    );
  }

  Widget _buildPlaceholder() {
    if (placeholder != null) return placeholder!;
    return _buildDefaultPlaceholder();
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey[400],
          size: (width ?? 100) * 0.3,
        ),
      ),
    );
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.broken_image,
          color: Colors.grey[400],
          size: (width ?? 100) * 0.3,
        ),
      ),
    );
  }

  Widget _buildMemoryImage() {
    return Image.memory(
      imageBytes!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildDefaultErrorWidget();
      },
    );
  }
}
