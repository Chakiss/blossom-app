import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class RatingView extends StatefulWidget {
  Function(int) _listener;

  RatingView(this._listener, {Key key}) : super(key: key);

  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              _setRating(1);
            },
            behavior: HitTestBehavior.opaque,
            child: Icon(
              Icons.star_rate_rounded,
              size: 50,
              color: _rating >= 1 ? Colors.yellow : BlossomTheme.lightGray,
            )),
        GestureDetector(
          onTap: () {
            _setRating(2);
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.star_rate_rounded,
            size: 50,
            color: _rating >= 2 ? Colors.yellow : BlossomTheme.lightGray,
          ),
        ),
        GestureDetector(
          onTap: () {
            _setRating(3);
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.star_rate_rounded,
            size: 50,
            color: _rating >= 3 ? Colors.yellow : BlossomTheme.lightGray,
          ),
        ),
        GestureDetector(
          onTap: () {
            _setRating(4);
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.star_rate_rounded,
            size: 50,
            color: _rating >= 4 ? Colors.yellow : BlossomTheme.lightGray,
          ),
        ),
        GestureDetector(
          onTap: () {
            _setRating(5);
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.star_rate_rounded,
            size: 50,
            color: _rating >= 5 ? Colors.yellow : BlossomTheme.lightGray,
          ),
        ),
      ],
    );
  }

  void _setRating(int score) {
    widget._listener.call(score);
    setState(() {
      _rating = score;
    });
  }
}
