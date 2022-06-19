import 'dart:html';

import 'package:amazon_clone/screen/cart_screen.dart';

import 'package:amazon_clone/screen/seacrh_screen.dart';
import 'package:amazon_clone/sell_product/description.dart';
import 'package:amazon_clone/sell_product/product_card.dart';
import 'package:amazon_clone/sell_product/sell_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _searchcontroller.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://img.icons8.com/color/2x/amazon.png',
          height: 55,
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
             

            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => home()));
                });
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => cartpage()));
                });
              },
              icon: Icon(
                Icons.shopping_cart,
              )),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return Container(
                  height: 900,
                  width: 1000,
                  margin: EdgeInsets.only(left: 50, top: 50, right: 30),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 4),
                    children: snapshot.data!.docs.map((document) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 78, 195, 175),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 60),
                                  height: 65,
                                  width: 65,
                                  child: Image.network(
                                    document['photourl'],
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                document['title'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                document['Price'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                document['Description'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 16, 1, 65),
                                    fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }

              return Text('There is no Products');

              /*  final List storedocs=[];
snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
  Map a=documentSnapshot.data() as Map<String,dynamic>;
  storedocs.add(a);
  a['id']=documentSnapshot.id;
},).toList();
              

 return Padding(
                padding: const EdgeInsets.only(left: 190),
                child: SingleChildScrollView(
                  child: Column(
                    
                          children:List.generate(
                            storedocs.length, 
                            
                          
                          (index) => Container(
                
                            height: 100,
                            width: 100,
                            
                            decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(13),
                  
                  image: DecorationImage(
                    image: NetworkImage(storedocs[index]['photourl'],),fit: BoxFit.cover)
                            ),
                            child: Column(
                              
                  children: [
                    Text(
                      storedocs[index]['title'],
                      style: TextStyle(color: Colors.red),
                       
                    ),
                
                   SizedBox(height: 10,),
                
                     Text(
                      storedocs[index]['Price'],
                      style: TextStyle(color: Colors.blue),
                       
                    ),

                     SizedBox(height: 10,),
                
                     Text(
                      storedocs[index]['Description'],
                       
                    )
                  ],
                            ),
                          )
                          
                          
                          ) ,
                  ),
                ),
              );
           
           
           
           */
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => sell_item()));

          FirebaseFirestore.instance
              .collection('products')
              .get()
              .then((QuerySnapshot querysnapshot) {
            querysnapshot.docs.forEach((doc) {
              print(doc['Price']);
            });
          });
        },
        child: Icon(Icons.sell_outlined),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: Text(
                'aditya',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "pinkesh.earth@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            AboutListTile(
              // <-- SEE HERE
              icon: Icon(
                Icons.info,
              ),
              child: Text('About app'),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'My Cool App',
              applicationVersion: '1.0.25',
              applicationLegalese: '© 2019 Company',
              aboutBoxChildren: [
                ///Content goes here...
              ],
            ),
          ],
        ),
      ),
    );
  }
}
