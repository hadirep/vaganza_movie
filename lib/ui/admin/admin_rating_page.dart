import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/data/service/storage_service.dart';
import 'package:vaganza_movie/ui/admin/widget_create_data.dart';
import 'package:vaganza_movie/ui/admin/widget_update_data.dart';

class AdminRatingPage extends StatefulWidget {
  const AdminRatingPage({Key? key}) : super(key: key);

  static const String routeName = 'admin_rating_page';

  @override
  State<AdminRatingPage> createState() => _AdminRatingPageState();
}

class _AdminRatingPageState extends State<AdminRatingPage> {
  final CollectionReference _rating = FirebaseFirestore.instance.collection('rating');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Admin Rating',
              style: TextStyle(color: darkPrimaryColor),
            ),
          ),
          backgroundColor: primaryColor,
        ),
        body: StreamBuilder(
          stream: _rating.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  final imageUrl = documentSnapshot['image']; // Ambil URL gambar dari Firestore
                  return Card(
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['genre']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => update(context, documentSnapshot),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => Storage().deleteFile(documentSnapshot.id, context),
                            ),
                          ],
                        ),
                      ),
                      leading: imageUrl != null && imageUrl.isNotEmpty
                          ? Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.camera_alt, size: 50),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => create(context),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}