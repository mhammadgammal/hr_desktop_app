import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAssetPicture extends ImageProvider<SvgAssetPicture> {
  final int width;
  final int height;
  final SvgPicture svgPicture;

  const SvgAssetPicture(this.svgPicture, {this.width = 200, this.height = 200});

  @override
  Future<SvgAssetPicture> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<SvgAssetPicture>(this);

  @override
  ImageStreamCompleter loadImage(
    SvgAssetPicture key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(_loadAsync());
  }

  Future<ImageInfo> _loadAsync() async {
    final pictureInfo = await vg.loadPicture(svgPicture.bytesLoader, null);
    final image = await pictureInfo.picture.toImage(
      width,
      height,
    ); // Fixed dimensions
    return ImageInfo(image: image);
  }
}
