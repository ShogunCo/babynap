import 'dart:async';

import 'package:flutter/material.dart';


Future<bool> onWillPop(BuildContext context) async {
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