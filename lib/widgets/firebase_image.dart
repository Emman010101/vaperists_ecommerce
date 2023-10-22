import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:vaperists_ecommerce/utils/loading.dart';

import '../data/global_vars.dart';

//using this class to get the image url on firebase storage using the filename
class FirebaseImage extends StatefulWidget {
  var fileName;
  var width, height;

  FirebaseImage({Key? key, this.fileName, this.width, this.height})
      : super(key: key);

  @override
  State<FirebaseImage> createState() => _FirebaseImageState();
}

class _FirebaseImageState extends State<FirebaseImage> {
  var imageUrl = '';
  bool imageIsLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImageUrl(widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return imageIsLoaded
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: widget.width,
            height: widget.height,
          )
        : Loading(color: textColor,);
  }

  Future<void> fetchImageUrl(fileName) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('products_images')
        .child(fileName + '.png');
    final url = await ref.getDownloadURL();

    setState(() {
      imageUrl = url.toString();
      imageIsLoaded = true;
    });

    map[fileName] = url.toString();
  }
}
