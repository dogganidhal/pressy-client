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
    return BoxDecoration(
      gradient: LinearGradient(
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
    return Container(
      child: SizedBox.expand(
        child: FlatButton(
          child: Text(
            action.title.toUpperCase(), 
            style: TextStyle(
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
        ),
      ),
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
    );
  }

  List<Widget> _buildWidgets(BuildContext context) {
    
    List<Widget> widgets = List();
    
    if (this.title != null)
      widgets.add(
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: Center(
            child: Text(
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
    return KeyboardAvoidingWidget(
      child: Container(
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(width: 36),
              Expanded(
                child: Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: this._buildWidgets(context),
                                )
                              )
                            ]
                          ),
                        )
                      ),
                      Positioned(
                        top: -18,
                        right: 18,
                        child: RoundCloseButton(
                          onPressed: () => Navigator.pop(context)
                        ),
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(width: 36)
            ],
          )
        ),
        decoration: this._boxDecoration(),
      )
    );
  }

}