import 'dart:io';

import 'package:blossom_clinic/usecase/download_fire_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/dialog/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class BlossomImage extends StatefulWidget {
  String fileStorePath;
  String imageKey;

  BlossomImage({this.fileStorePath, this.imageKey});

  @override
  _BlossomImageState createState() => _BlossomImageState();
}

class _BlossomImageState extends State<BlossomImage> {
  String imagePath = "";
  DownloadFileFromCloudStorageUseCase _downloadFileFromCloudStorageUseCase = Injector.appInstance.get();
  UserData _userData = Injector.appInstance.get();

  @override
  void initState() {
    super.initState();
    if (widget.imageKey != null) {
      imagePath = _getLocalUrlPath();
    }
    if (widget.fileStorePath != null) {
      imagePath = _userData.getImagePathFromLocal(widget.fileStorePath);
      _downloadFileFromCloudStorage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (imagePath.isNotEmpty) {
              showDialog(context: context, builder: (BuildContext context) {
                return ImageDialog(imagePath);
              },);
            }
          },
          child: Container(
              width: 50 * MediaQuery.of(context).size.width / 100,
              child: Image.file(File(imagePath))),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  String _getLocalUrlPath() {
    final map = _userData.getMapFilePath().entries.firstWhere((element) => element.key.contains(widget.imageKey));
    return map.value;
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
