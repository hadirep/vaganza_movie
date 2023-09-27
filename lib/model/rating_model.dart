class RatingModel {
  String name;
  String genre;
  String duration;
  String direction;
  String ageRating;
  String movieRating;
  String synopsis;
  String imageAsset;

  RatingModel({
    required this.name,
    required this.genre,
    required this.duration,
    required this.direction,
    required this.ageRating,
    required this.movieRating,
    required this.synopsis,
    required this.imageAsset,
  });
}

var ratingModel = [
  RatingModel(
    name: "THE BATMAN",
    genre: "Action, Crime, Drama",
    duration: "2 Jam 56 Menit",
    direction: "Matt Reeves",
    ageRating: "R13+",
    movieRating: "9.2",
    synopsis:
        "Di tahun kedua memerangi kejahatan, Batman mengungkap korupsi besar di Gotham City yang menghubungkan keluarganya sendiri dan menghadapi pembunuh berantai yang dikenal sebagai Riddler.",
    imageAsset: "assets/the-batman.jpg",
  ),
  RatingModel(
    name: "UNCHARTED",
    genre: "Action",
    duration: "1 Jam 56 Menit",
    direction: "Ruben Fleischer",
    ageRating: "R13+",
    movieRating: "9.2",
    synopsis:
        "Nathan Drake(Tom Holland) adalah seorang bartender yang pintar. Ia mengaku sebagai keturunan dari penjelajah kenamaan asala Inggris bernama Sir Francis Drake."
        "Bersama Viktor Sulivan (Mark Wahlberg) ia mengarungi lautan untuk mencari harta karun terbesar yang tidak pernah ditemukan dan mencari petunjuk kakanya yang hilang.",
    imageAsset: "assets/uncharted.jpg",
  ),
  RatingModel(
    name: "GARIS WAKTU",
    genre: "Drama",
    duration: "1 Jam 40 Menit",
    direction: "Jeihan Angga",
    ageRating: "R13+",
    movieRating: "8.3",
    synopsis:
        "APRIL, seorang gadis dengan kegemaran menulis puisi bertemu dengan SENANDIKA, musisi yang berhasil mencuri perhatian dengan filosofi dan prinsipnya. April yang melihat potensi pada diri Sena -- nama panggilan yang April berikan pada Senandika -- pun memperkenalkannya pada SANYA, produser muda sahabat April yang selalu menjalani hidup dengan bebas \n"
        "Konflik dimulai ketika April dan Sena sudah saling jatuh cinta, namun terhalang restu ayah April, HALIM, yang menilai Sena tidaklah pantas untuk menjadi pendamping anaknya. Segera setelah mengetahui kedekatan April dan Sena, Halim mengirim sang anak ke London dengan tujuan menjauhkannya dari Sena. Selama jarak memisahkannya dengan Sena, April menitipkan perjuangan karir Sena pada Sanya, dengan harapan kesuksesan Sena akan meluluhkan Halim dan membuatnya merestui hubungan April dan Sena. \n"
        "Bertahun kemudian, April kembali ke Indonesia dan menyaksikan sendiri kesuksesan yang telah berhasil diraih Sena. Sayang, kesalahpahaman yang terjadi antara April, Sena, dan Sanya melahirkan keraguan di hati April untuk Sena.",
    imageAsset: "assets/garis-waktu.jpg",
  ),
  RatingModel(
    name: "DEATH ON THE NILE",
    genre: "Crime, Drama, Mystery",
    duration: "2 Jam 7 Menit",
    direction: "Kenneth Branagh",
    ageRating: "R13+",
    movieRating: "8.7",
    synopsis:
        "Aksi Hercule Poirot kembali lagi. Sang detektif kali ini akan menyelidiki sebuah pembunuhan seorang ahli waris muda di Sungai Nil. Siapa pembunuhnya?",
    imageAsset: "assets/death-on-the-nile.jpg",
  ),
];
