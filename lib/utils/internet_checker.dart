
import 'dart:io';

import 'package:vaperists_ecommerce/utils/snackbar.dart';

Future isConnectedToInternet(context) async{
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      snackBar(context, 'Connected to internet');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    snackBar(context, 'Please check your internet connection.');
    return false;
  }
}