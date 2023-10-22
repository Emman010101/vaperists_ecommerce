
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

void loadingDialog(context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            color: textColor,
          ),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );

    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
}