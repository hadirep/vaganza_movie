import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/data/service/storage_service.dart';
import 'package:vaganza_movie/ui/admin/admin_create_data_playing.dart';
import 'package:vaganza_movie/ui/admin/admin_update_data_playing.dart';

class AdminPlayPage extends StatefulWidget {
  const AdminPlayPage({Key? key}) : super(key: key);

  static const String routeName = 'admin_play_page';

  @override
  State<AdminPlayPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPlayPage> {
  final CollectionReference _play = FirebaseFirestore.instance.collection('play');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Admin Playing',
              style: TextStyle(color: secondaryColor),
            ),
          ),
          backgroundColor: primaryColor,
        ),
        body: StreamBuilder(
          stream: _play.snapshots(),
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
                              onPressed: () => updatePlaying(context, documentSnapshot),
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
          onPressed: () => createPlay(context),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}