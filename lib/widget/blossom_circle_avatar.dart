import 'dart:io';

import 'package:blossom_clinic/usecase/download_fire_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class BlossomCircleAvatar extends StatefulWidget {
  String fileStorePath;
  String imageKey;
  double _radius;

  BlossomCircleAvatar(this._radius, {this.fileStorePath, this.imageKey});

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
    return CircleAvatar(
      radius: widget._radius,
      backgroundColor: Colors.white,
      backgroundImage: imagePath?.isEmpty ?? true ? AssetImage("assets/profile_place_holder.png") : FileImage(File(imagePath)),
    );
  }

  String _getLocalUrlPath() {
    if (_userData.getMapFilePath().containsKey(widget.imageKey)) {
      return _userData.getMapFilePath()[widget.imageKey];
    } else {
      return "";
    }
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
