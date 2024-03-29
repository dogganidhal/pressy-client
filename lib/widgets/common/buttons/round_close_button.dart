import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

typedef void OnButtonPressed();

class RoundCloseButton extends StatelessWidget {

  final double dimension;
  final OnButtonPressed onPressed;

  RoundCloseButton({@required this.onPressed, this.dimension = 36}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        child: MaterialButton(
          elevation: 1,
          padding: EdgeInsets.all(0),
          splashColor: Colors.transparent,
          onPressed: this.onPressed,
          child: Center(
            child: Icon(Icons.close, color: Colors.white) 
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.dimension / 2),
          color: ColorPalette.red
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.dimension / 2),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.textBlack.withAlpha(64),
            offset: Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 2
          )
        ]
      ),
      width: this.dimension,
      height: this.dimension,
    );
  }

}