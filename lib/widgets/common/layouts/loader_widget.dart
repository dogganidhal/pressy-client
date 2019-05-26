import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LoaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.25],
          colors: [
            Colors.black.withAlpha((255 * 0.9).toInt()),
            Colors.black.withAlpha((255 * 0.75).toInt())
          ]
        )
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 36),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 8),
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      "CHARGEMENT",
                      style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 14, color: Colors.grey)
                    ),
                    SizedBox(height: 8)
                  ],
                ),
              )
            ),
            SizedBox(width: 36),
          ],
        )
      ),
    );
  }

}