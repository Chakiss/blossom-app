import 'dart:io';

import 'package:blossom_clinic/usecase/download_fire_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class BlossomCircleAvatar extends StatefulWidget {
  String _fileStorePath;
  double _radius;

  BlossomCircleAvatar(this._fileStorePath, this._radius);

  @override
  _BlossomCircleAvatarState createState() => _BlossomCircleAvatarState();
}

class _BlossomCircleAvatarState extends State<BlossomCircleAvatar> {
  String imagePath = "";
  DownloadFileFromCloudStorageUseCase _downloadFileFromCloudStorageUseCase = Injector.appInstance.get();
  UserData _userData = Injector.appInstance.get();

  @override
  void initState() {
    super.initState();
    imagePath = _userData.getImagePathFromLocal(widget._fileStorePath);
    _downloadFileFromCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget._radius,
      backgroundColor: Colors.white,
      backgroundImage: FileImage(File(imagePath)),
    );
  }

  Future<void> _downloadFileFromCloudStorage() async {
    if (imagePath.isEmpty) {
      final result = await _downloadFileFromCloudStorageUseCase.execute(widget._fileStorePath);
      result.whenWithResult((filePath) {
        setState(() {
          imagePath = filePath;
        });
      }, (map) {});
    }
  }
}
