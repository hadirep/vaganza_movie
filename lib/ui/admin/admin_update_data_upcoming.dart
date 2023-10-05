import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vaganza_movie/data/service/storage_service.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _genreController = TextEditingController();
final TextEditingController _durationController = TextEditingController();
final TextEditingController _directorController = TextEditingController();
final TextEditingController _ageRatingController = TextEditingController();
final TextEditingController _synopsisController = TextEditingController();

bool isImageSelected = false;
String? imageUrl;
final CollectionReference _upcoming = FirebaseFirestore.instance.collection('upcoming');

Future<void> updateUpcoming(context, [DocumentSnapshot? documentSnapshot]) async {
  if (documentSnapshot != null) {
    final String oldImageUrl = documentSnapshot['image'] ?? '';

    _nameController.text = documentSnapshot['name'];
    _genreController.text = documentSnapshot['genre'];
    _durationController.text = documentSnapshot['duration'];
    _directorController.text = documentSnapshot['director'];
    _ageRatingController.text = documentSnapshot['ageRating'];
    _synopsisController.text = documentSnapshot['synopsis'];
    imageUrl = documentSnapshot['image'];

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
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
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

                          if (oldImageUrl.isNotEmpty) {
                            try {
                              final storageReference = FirebaseStorage.instance
                                  .refFromURL(oldImageUrl);
                              await storageReference.delete();
                            } on firebase_core.FirebaseException catch (e) {
                              print("error delete image: $e");
                            }
                          }

                          await Storage().uploadFile(
                            imageFile.path,
                            imagePath,
                          );

                          final newImageUrl =
                          await Storage().downloadUrl(imagePath);

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
                  TextField(
                    controller: _durationController,
                    decoration: const InputDecoration(labelText: 'Duration'),
                  ),
                  TextField(
                    controller: _directorController,
                    decoration: const InputDecoration(labelText: 'Director'),
                  ),
                  TextField(
                    controller: _ageRatingController,
                    decoration: const InputDecoration(labelText: 'Age Rating'),
                  ),
                  TextField(
                    controller: _synopsisController,
                    decoration: const InputDecoration(labelText: 'Synopsis'),
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
                      child: const Text('Update'),
                      onPressed: () async {
                        final String name = _nameController.text;
                        final String genre = _genreController.text;
                        final String duration = _durationController.text;
                        final String director = _directorController.text;
                        final String ageRating = _ageRatingController.text;
                        final String synopsis = _synopsisController.text;
                        final String? selectedImageUrl = imageUrl;

                        await _upcoming.doc(documentSnapshot.id).update({
                          "name": name,
                          "genre": genre,
                          "duration": duration,
                          "director": director,
                          "ageRating": ageRating,
                          "synopsis": synopsis,
                          "image": selectedImageUrl,
                        });

                        _nameController.text = '';
                        _genreController.text = '';
                        _durationController.text = '';
                        _directorController.text = '';
                        _ageRatingController.text = '';
                        _synopsisController.text = '';
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
}