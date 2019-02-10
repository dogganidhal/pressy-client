import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/common/buttons/round_close_button.dart';
import 'package:pressy_client/widgets/common/layouts/keyboard_avoiding_widget.dart';


enum ModalActionType {
  OK, DESTROY, CANCEL   
}

typedef void ModalActionCallback();

class ModalAction {

  final String title;
  final ModalActionType type;
  final ModalActionCallback callback;

  ModalAction({@required this.title, @required this.callback, this.type = ModalActionType.OK});

}

class Modal extends StatelessWidget {

  final Widget child;
  final String title;
  final List<ModalAction> actions;

  Modal({Key key, @required this.child, this.actions = const [], this.title}) : super(key: key);

  BoxDecoration _boxDecoration() {
    return new BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.25],
        colors: [
          Colors.black.withAlpha((255 * 0.9).toInt()), 
          Colors.black.withAlpha((255 * 0.75).toInt())
        ]
      )
    );
  }

  Color _actionButtonColor(ModalActionType type) {
    switch(type) {
      case ModalActionType.OK:
        return ColorPalette.orange;
      case ModalActionType.CANCEL:
        return ColorPalette.textGray;
      default:
        return ColorPalette.red;
    }
  }

  Widget _actionButton(BuildContext context, ModalAction action) {
    return new Container(
      child: new SizedBox.expand(
        child: new FlatButton(
          child: new Text(
            action.title.toUpperCase(), 
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
          ),
          onPressed: () {
            Navigator.pop(context);
            if (action.callback != null)
              action.callback();
          },
          color: _actionButtonColor(action.type),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8))
        ),
      ),
      height: 56,
      padding: new EdgeInsets.only(left: 8, right: 8, bottom: 8),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(8)
      ),
    );
  }

  List<Widget> _buildWidgets(BuildContext context) {
    
    List<Widget> widgets = new List();
    
    if (this.title != null)
      widgets.add(
        new Container(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: new Center(
            child: new Text(
              this.title.toUpperCase(), 
              style: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.bold)
            ),
          ),
        )
      );

    widgets.add(this.child);

    for (var action in this.actions)
      widgets.add(this._actionButton(context, action));

     return widgets;
  }
  
  @override
  Widget build(BuildContext context) {
    return new KeyboardAvoidingWidget(
      child: new Container(
        child: new Center(
          child: new Row(
            children: <Widget>[
              new SizedBox(width: 36),
              new Expanded(
                child: new Container(
                  child: new Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      new DecoratedBox(
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(new Radius.circular(8))
                        ),
                        child: new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              new Expanded(
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: this._buildWidgets(context),
                                )
                              )
                            ]
                          ),
                        )
                      ),
                      new Positioned(
                        top: -18,
                        right: 18,
                        child: new RoundCloseButton(
                          onPressed: () => Navigator.pop(context)
                        ),
                      ),
                    ],
                  ),
                )
              ),
              new SizedBox(width: 36)
            ],
          )
        ),
        decoration: this._boxDecoration(),
      )
    );
  }

}