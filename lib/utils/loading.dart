import 'package:flutter/material.dart';
import 'colors.dart';

class Loading extends StatefulWidget {
  var color;
  Loading({Key? key,this.color}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: widget.color,
      ),
    );
  }
}

