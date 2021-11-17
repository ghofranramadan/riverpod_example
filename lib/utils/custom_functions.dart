import 'package:flutter/material.dart';

class CustomFunctions {
  static navigateScreen(
      {BuildContext context, String nextScreenTitle, Widget nextScreen}) async {
    // var screenTitleProvider =
    //     Provider.of<ScreenTitleProvider>(context, listen: false);

    // String prevTitle = screenTitleProvider.title;
    // screenTitleProvider.setTitle(nextScreenTitle);
    // await Navigator.push(
    //     context, MaterialPageRoute(builder: (ctx) => nextScreen));
    // screenTitleProvider.setTitle(prevTitle);
  }

  static navigateNextScreen({BuildContext context, Widget nextScreen}) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => nextScreen));
  }
}
