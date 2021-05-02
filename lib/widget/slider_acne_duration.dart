import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

import '../blossom_theme.dart';

class SliderAcneDuration extends StatefulWidget {

  Function(String) _listener;

  SliderAcneDuration(this._listener);

  @override
  _SliderAcneDurationState createState() => _SliderAcneDurationState();
}

class _SliderAcneDurationState extends State<SliderAcneDuration> {

  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Column(
        children: [
          Slider(
            activeColor: BlossomTheme.darkPink,
            inactiveColor: BlossomTheme.lightPink,
            value: _currentSliderValue,
            min: 1,
            max: 12,
            divisions: 11,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              widget._listener.call(value.floor().toString());
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          BlossomText("${_currentSliderValue.floor()} เดือน", size: 14,)
        ],
      ),
    );
  }
}
