import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class Storage {
  final storageRef = FirebaseStorage.instance.ref();
  final CollectionReference _play = FirebaseFirestore.instance.collection('play');

  Future<void> deleteFile(String productId, context) async {
    final DocumentSnapshot documentSnapshot = await _play.doc(productId).get();
    final String imageUrl = documentSnapshot['image'] ?? ''; // Ambil URL gambar dari Firestore

    // Hapus dokumen dari Firestore
    await _play.doc(productId).delete();

    // Hapus gambar dari Firebase Storage berdasarkan URL gambar
    try {
      final storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageReference.delete();
    } on firebase_core.FirebaseException catch(e) {
      print(e);
    }

    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You have successfully deleted a product')));
    }
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      final desertRef = storageRef.child('assets/$fileName');
      await desertRef.putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> downloadUrl(String imageName) async {
    final desertRef = storageRef.child('assets/$imageName');
    String downloadURL = await desertRef.getDownloadURL();

    return downloadURL;
  }
}