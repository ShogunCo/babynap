import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> questionOnWillPop(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Eminmisiniz?'),
          content: Text('Testden çıkmak istiyor musunuz?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Hayır'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Evet'),
            ),
          ],
        ),
      )) ??
      false;
}

Future<bool> appOnWillPop(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Eminmisiniz?'),
      content: Text('Testden çıkmak istiyor musunuz?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Hayır'),
        ),
        FlatButton(
          onPressed: () => SystemNavigator.pop(),
          child: Text('Evet'),
        ),
      ],
    ),
  )) ??
      false;
}


Future<bool> resultOnWillPop(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Eminmisiniz?'),
      content: Text('Teste tekrar başlamak istiyor musunuz'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Hayır'),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Evet'),
        ),
      ],
    ),
  )) ??
      false;
}


Future<T> pushPage<T>(BuildContext context, Widget page) {
  return Navigator.of(context)
      .push<T>(MaterialPageRoute(builder: (context) => page));
}
