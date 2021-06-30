import 'dart:io';

import 'package:blossom_clinic/usecase/download_fire_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class BlossomProfileAvatar extends StatefulWidget {
  String imageUrl;
  double _radius;

  BlossomProfileAvatar(this._radius, {this.imageUrl = ""});

  @override
  _BlossomProfileAvatarState createState() => _BlossomProfileAvatarState();
}

class _BlossomProfileAvatarState extends State<BlossomProfileAvatar> {

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget._radius,
      backgroundColor: Colors.white,
      backgroundImage: widget.imageUrl?.isEmpty ?? true ? AssetImage("assets/profile_place_holder.png") : NetworkImage(widget.imageUrl),
    );
  }
}
