import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin ImagePickerBuilder {
  Future<List<AssetEntity>> pickImages({
    required BuildContext context,
    int? thumbnailWidth,
    int? thumbnailHeight,
  }) async {
    const maxFiles = 300;

    final files = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: maxFiles
      ),
    );

    if (files == null) return [];

    if (thumbnailWidth != null && thumbnailHeight != null) {
      final int screenResMultipler = 3;

      for (final file in files) {
        await file.thumbnailDataWithSize(
          ThumbnailSize(
            thumbnailWidth * screenResMultipler,
            thumbnailHeight * screenResMultipler,
          ),
        );
      }
    }

    return files;
  }
}
