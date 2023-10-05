import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/model/location_model.dart';

class WidgetLocation extends StatefulWidget {
  const WidgetLocation({Key? key}) : super(key: key);

  static const routeName = '/widget_location';

  @override
  State<WidgetLocation> createState() => _WidgetLocationState();
}

class _WidgetLocationState extends State<WidgetLocation> {
  String _nameLocation = '';
  final _textController = TextEditingController();
  final CollectionReference _location =
  FirebaseFirestore.instance.collection('location');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          elevation: 1,
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: secondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Flexible(
              child: Padding(
                padding:
                const EdgeInsets.only(left: 48, right: 16, top: 4),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: "Masukkan Kata Kunci",
                    border: InputBorder.none,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _nameLocation = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor,
      body: StreamBuilder(
        stream: _location
            .where('city', isGreaterThanOrEqualTo: _nameLocation)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }
          if (streamSnapshot.hasError) {
            return const Center(
              child: Text('Terjadi kesalahan.'),
            );
          }
          if (!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Tidak ada hasil.'),
            );
          }
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
              streamSnapshot.data!.docs[index];
              final model = LocationModel(
                city: documentSnapshot['city'],
              );
              return InkWell(
                onTap: () {
                  Navigator.pop(context, model.city);
                },
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(model.city),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}