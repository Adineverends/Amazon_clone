import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class home extends StatefulWidget {
 

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
/*  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['title'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  } */
 String name = "";
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
  /*    body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(hintText: 'Search by name'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GridView.count(
              padding: EdgeInsets.only(left: 10, right: 10),
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              shrinkWrap: true,
              children: tempSearchStore.map((e) {
                return buildResultcard(e);
              }).toList())
        ],
      ), */





 body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
                .collection('products')
                .where("searchKeywords", arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            data['photourl'],
                            width: 150,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              Text(
                                data['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),

                               Text(
                                data['Price'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          
                        ],
                      ),
                    );
                  },
                );
        },
      ),











    );
  }

/*  Widget buildResultcard(data) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Container(
            child: Center(
          child: Text(
            data['title'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ), // TextStyle ) // Text ) // Center
          ),
        )));
  } */
}




