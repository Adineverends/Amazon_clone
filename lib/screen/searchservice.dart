import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('searchkey', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
