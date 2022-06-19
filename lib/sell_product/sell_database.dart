import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../authentication/storagemethods.dart';

class sellerdata {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> sell_data({
    required String title,
    required String price,
    required String description,
    required Uint8List file,
  }) async {
    String res = 'Some error ocurred';
    try {
      if (title.isNotEmpty ||
          price.isNotEmpty ||
          description.isNotEmpty ||
          file != null) {
        String photourl = await StorageMethods()
            .uploadImageToStorage('ProductPics', file, false);

        await _firestore.collection('products').add({
          'title': title,
          'Price': price,
          'Description': description,
          'photourl': photourl
        });

        res = 'sucess';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
