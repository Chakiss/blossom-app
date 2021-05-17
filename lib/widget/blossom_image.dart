import 'dart:io';

import 'package:blossom_clinic/usecase/download_fire_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/widget/dialog/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class BlossomImage extends StatefulWidget {
  String fileStorePath;
  double width;

  BlossomImage({this.fileStorePath, this.width});

  @override
  _BlossomImageState createState() => _BlossomImageState();
}

class _BlossomImageState extends State<BlossomImage> {
  String imagePath = "";
  DownloadFileFromCloudStorageUseCase _downloadFileFromCloudStorageUseCase = Injector.appInstance.get();
  SharedPrefUtils _sharedPrefUtils = Injector.appInstance.get();

  @override
  void initState() {
    super.initState();
    if (_sharedPrefUtils.getMapFilePath().containsKey(widget.fileStorePath)) {
      imagePath = _sharedPrefUtils.getMapFilePath()[widget.fileStorePath];
    } else {
      if (widget.fileStorePath != null) {
        _downloadFileFromCloudStorage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (imagePath.isNotEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ImageDialog(imagePath);
                },
              );
            }
          },
          child: Container(
              width: widget.width ?? 50 * MediaQuery.of(context).size.width / 100,
              child: imagePath?.isEmpty ?? true ? Container() : Image.file(File(imagePath))),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Future<void> _downloadFileFromCloudStorage() async {
    if (imagePath.isEmpty) {
      final result = await _downloadFileFromCloudStorageUseCase.execute(widget.fileStorePath);
      result.whenWithResult((filePath) {
        setState(() {
          imagePath = filePath;
        });
      }, (map) {});
    }
  }
}
