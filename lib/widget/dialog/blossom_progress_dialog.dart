import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:flutter/material.dart';

class BlossomProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        child: Center(
          child: BlossomProgressIndicator(),
        ),
      ),
    );
  }
}
