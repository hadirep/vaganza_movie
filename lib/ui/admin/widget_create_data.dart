import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vaganza_movie/data/service/storage_service.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _genreController = TextEditingController();
bool isImageSelected = false; // Tambahkan variabel ini untuk melacak apakah gambar telah dipilih
String? imageUrl; // Ubah tipe data imageUrl menjadi nullable

final CollectionReference _play = FirebaseFirestore.instance.collection('play');

Future<void> create(context) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: imageUrl != null
                          ? Image.network(
                        imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.camera_alt, size: 100),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(10, 35)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text('Choose Image'),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        final imageFile = File(pickedFile.path);
                        final imageName = const Uuid().v4();
                        final imagePath = '$imageName.jpg';

                        await Storage().uploadFile(
                          imageFile.path,
                          imagePath,
                        );

                        final newImageUrl = await Storage().downloadUrl(
                          imagePath,
                        );

                        setState(() {
                          imageUrl = newImageUrl;
                        });
                      }
                    },
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _genreController,
                  decoration: const InputDecoration(labelText: 'Genre'),
                ),
                const SizedBox(height: 5),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 35)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text('Create'),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String genre = _genreController.text;
                      final String? selectedImageUrl = imageUrl;

                      await _play.add({
                        "name": name,
                        "genre": genre,
                        "image": selectedImageUrl,
                      });

                      _nameController.text = '';
                      _genreController.text = '';
                      imageUrl = null;
                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}