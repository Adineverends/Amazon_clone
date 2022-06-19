import 'dart:typed_data';

import 'package:amazon_clone/screen/home.dart';
import 'package:amazon_clone/sell_product/sell_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class sell_item extends StatefulWidget {
  const sell_item({Key? key}) : super(key: key);

  @override
  State<sell_item> createState() => _sell_itemState();
}

class _sell_itemState extends State<sell_item> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController Description = TextEditingController();

  Uint8List? _ProductImage;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    price.dispose();

    Description.dispose();
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();

    XFile? _file = await _imagepicker.pickImage(source: source);

    if (_file != null) {
      // we are using uint8list bcz it is avalable in web
      return await _file.readAsBytes();
    }

    print('no image selected');
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  void selectImage() async {
    final ImagePicker _picker = ImagePicker();
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _ProductImage = im;
    });
  }

  void Send_sellerData() async {
    setState(() {
      isLoading = true;
    });

    String res = await sellerdata().sell_data(
        title: title.text,
        price: price.text,
        description: Description.text,
        file: _ProductImage!);

    setState(() {
      isLoading = false;
    });

    if (res != 'sucess') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register Your Products \n here TO SELL',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 237, 233, 120)),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: title,
            decoration: InputDecoration(hintText: 'Product Title'),
          ),
          SizedBox(
            height: 14,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: price,
            decoration: InputDecoration(hintText: 'Product Price'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: Description,
            decoration: InputDecoration(hintText: 'Product Description'),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Now add Product photo',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 237, 233, 120)),
          ),
          SizedBox(
            height: 20,
          ),
          _ProductImage != null
              ? Container(
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: MemoryImage(_ProductImage!),
                          fit: BoxFit.cover)),
                )
              : IconButton(
                  onPressed: () {
                    selectImage();
                  },
                  icon: Icon(Icons.add_a_photo)),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () async {
             
              Send_sellerData();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Home()));

           

            
            },
            child: Text('SELL PRODUCT'),
            color: Colors.blueAccent,
          )
        ],
      ),
    ));
  }
}
