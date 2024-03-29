import 'package:flutter/cupertino.dart';

class KeyboardAvoidingWidget extends StatelessWidget {
  
  final Widget child;

  KeyboardAvoidingWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      padding: mediaQuery.viewInsets,
      duration: const Duration(milliseconds: 300),
      child: child
    );
  }

}