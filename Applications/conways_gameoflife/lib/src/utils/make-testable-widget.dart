import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conways_gameoflife/src/utils/size-config.dart';

Widget makeTestableWidget({child}) {
  return MaterialApp(home: Builder(builder: (BuildContext context) {
    SizeConfig.init(context);
    return Container(child: child);
  }));
}
