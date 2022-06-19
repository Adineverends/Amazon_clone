import 'package:amazon_clone/sell_product/description.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  DocumentSnapshot doc;
  ProductCard({Key? key, required this.doc}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
/*  late String _title;
  late String _price;
  late String _description;

  void getData() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('products').doc().get();
    _title = doc.get('title');
    _price = doc.get('Price');
    _description = doc.get('Description');
  } */

  late DocumentSnapshot doc;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doc['title'],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              doc['Price'],
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              doc['Description'],
              style: TextStyle(
                  color: Color.fromARGB(255, 16, 1, 65), fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}



/*Widget notedcard(Function()? onTap,QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           doc['title'],
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            doc['price'],
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
           doc ['Description'],
            style:
                TextStyle(color: Color.fromARGB(255, 16, 1, 65), fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ), 
  );
} */


