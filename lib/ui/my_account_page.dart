import 'package:flutter/material.dart';

var fontStyle = const TextStyle(fontFamily: "fonts/RobotoCondensed-Bold.ttf");

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset('assets/logo.png', width: 180, height: 50),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        child: ListView(
          children: <Widget>[
            Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/hadi.jpg"),
                        ),
                        const SizedBox(height: 30),
                        const Column(
                          children: <Widget>[
                            Text(
                              "HADI RAHMAH ESA PUTRA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 8),
                                Text(
                                  "Gender : Pria",
                                  style: fontStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            Text(
                              "Alamat: Tangerang",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            Text(
                              "Pekerjaan: Fresh Graduate",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            Text(
                              "Tempat/Tgl Lahir: Tangerang, 21 Juli 2000",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "TENTANG SAYA",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            "Saya menyukai hal baru, lebih menyukai proses dari pada hasil dan "
                            "tidak takut akan resiko, karena menurut saya ketika menyerah sebelum mencoba sama saja menghentikan perkembangan bagi diri kita sendiri",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "KATA MUTIARA",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            "Tiada orang bodoh di dunia ini, yang ada hanya orang malas yang tidak mau belajar",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
