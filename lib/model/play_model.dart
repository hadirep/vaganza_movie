class PlayModel {
  String name;
  String genre;
  String duration;
  String director;
  String ageRating;
  String movieRating;
  String synopsis;
  String imageAsset;

  PlayModel({
    required this.name,
    required this.genre,
    required this.duration,
    required this.director,
    required this.ageRating,
    required this.movieRating,
    required this.synopsis,
    required this.imageAsset,
  });
}

var playModel = [
  PlayModel(
    name: "THE BATMAN",
    genre: "Action, Crime, Drama",
    duration: "2 Jam 56 Menit",
    director: "Matt Reeves",
    ageRating: "R13+",
    movieRating: "9.2",
    synopsis:
        "Di tahun kedua memerangi kejahatan, Batman mengungkap korupsi besar di Gotham City yang menghubungkan keluarganya sendiri dan menghadapi pembunuh berantai yang dikenal sebagai Riddler.",
    imageAsset: "assets/the-batman.jpg",
  ),
  PlayModel(
    name: "GRETEL & HANSEL",
    genre: "Fantasy, Horror, Thriller",
    duration: "1 Jam 27 Menit",
    director: "Osgood Perkins",
    ageRating: "R13+",
    movieRating: "6.0",
    synopsis:
        "Dahulu kala di sebuah desa dongeng yang jauh di sana, seorang gadis muda membimbing adik lelakinya ke dalam hutan yang gelap mencari makanan dan pekerjaan, dan mereka menemukan sebuah pusat kejahatan yang menakutkan.",
    imageAsset: "assets/gretel-hansel.jpg",
  ),
  PlayModel(
    name: "UNCHARTED",
    genre: "Action",
    duration: "1 Jam 56 Menit",
    director: "Ruben Fleischer",
    ageRating: "R13+",
    movieRating: "9.2",
    synopsis:
        "Nathan Drake(Tom Holland) adalah seorang bartender yang pintar. Ia mengaku sebagai keturunan dari penjelajah kenamaan asala Inggris bernama Sir Francis Drake."
        "Bersama Viktor Sulivan (Mark Wahlberg) ia mengarungi lautan untuk mencari harta karun terbesar yang tidak pernah ditemukan dan mencari petunjuk kakanya yang hilang.",
    imageAsset: "assets/uncharted.jpg",
  ),
  PlayModel(
    name: "GARIS WAKTU",
    genre: "Drama",
    duration: "1 Jam 40 Menit",
    director: "Jeihan Angga",
    ageRating: "R13+",
    movieRating: "8.3",
    synopsis:
        "APRIL, seorang gadis dengan kegemaran menulis puisi bertemu dengan SENANDIKA, musisi yang berhasil mencuri perhatian dengan filosofi dan prinsipnya. April yang melihat potensi pada diri Sena -- nama panggilan yang April berikan pada Senandika -- pun memperkenalkannya pada SANYA, produser muda sahabat April yang selalu menjalani hidup dengan bebas \n\n"
        "\n Konflik dimulai ketika April dan Sena sudah saling jatuh cinta, namun terhalang restu ayah April, HALIM, yang menilai Sena tidaklah pantas untuk menjadi pendamping anaknya. Segera setelah mengetahui kedekatan April dan Sena, Halim mengirim sang anak ke London dengan tujuan menjauhkannya dari Sena. Selama jarak memisahkannya dengan Sena, April menitipkan perjuangan karir Sena pada Sanya, dengan harapan kesuksesan Sena akan meluluhkan Halim dan membuatnya merestui hubungan April dan Sena. \n"
        "\n Bertahun kemudian, April kembali ke Indonesia dan menyaksikan sendiri kesuksesan yang telah berhasil diraih Sena. Sayang, kesalahpahaman yang terjadi antara April, Sena, dan Sanya melahirkan keraguan di hati April untuk Sena.",
    imageAsset: "assets/garis-waktu.jpg",
  ),
  PlayModel(
    name: "GREAT WHITE",
    genre: "Thriller",
    duration: "1 Jam 31 Menit",
    director: "Martin Wilson",
    ageRating: "R13+",
    movieRating: "7.4",
    synopsis:
        "Penerbangan yang menyenangkan ke pulau terpencil berubah menjadi mimpi buruk bagi lima penumpang ketika pesawat amfibi mereka hancur dalam kecelakaan yang aneh dan mereka terjebak di rakit di tengah laut dengan hiu pemakan manusia bersembunyi di bawah permukaan.",
    imageAsset: "assets/great-white.jpg",
  ),
  PlayModel(
    name: "DEATH ON THE NILE",
    genre: "Crime, Drama, Mystery",
    duration: "2 Jam 7 Menit",
    director: "Kenneth Branagh",
    ageRating: "R13+",
    movieRating: "8.7",
    synopsis:
        "Aksi Hercule Poirot kembali lagi. Sang detektif kali ini akan menyelidiki sebuah pembunuhan seorang ahli waris muda di Sungai Nil. Siapa pembunuhnya?",
    imageAsset: "assets/death-on-the-nile.jpg",
  ),
  PlayModel(
    name: "MARRY ME",
    genre: "Comedy, Music, Romance",
    duration: "1 Jam 52 Menit",
    director: "Kat Coiro",
    ageRating: "R13+",
    movieRating: "6.1",
    synopsis:
        "Romansa tidak biasa antara superstar musik Kat Valdez (Jennifer Lopez) dan Charlie Gilbert (Owen Wilson) seorang guru matematika.\n "
        "Bermula saat Kat dikhianati oleh Bastian (Maluma) yang harusnya jadi suaminya. Maluma diketahui selingkuh sebelum keduanya resmi menikah. Kat pun akhirnya memutuskan untuk menikahi Charlie, orang asing yang ditemui di acara konser musiknya.",
    imageAsset: "assets/marry-me.jpg",
  ),
  PlayModel(
    name: "KUKIRA KAU RUMAH",
    genre: "Drama, Romance",
    duration: "1 Jam 30 Menit",
    director: "Umay Shahab",
    ageRating: "R13+",
    movieRating: "6.3",
    synopsis:
        "PRAM, seorang pemuda yang kesepian, yang tak dapat bentuk rasa 'kasih' dari kedua orang tuanya. Kekosongannya ia isi dengan menciptakan lagu-lagu bagus yang tak pernah didengar siapapun. Sampai kemudian, Pram yang bekerja di sebuah kafe music untuk membuatnya bisa mendapatkan jatah manggung, bertemu dan berkenalan dengan NISKALA, seseorang yang berbeda dari wanita-wanita lainnya dan Niskala juga benar-benar 'mendengarnya' benar benar mendengarnya, namun Pram belum mengetahui bahwa Niskala merupakan ODB (orang dengan bipolar). Namun semenjak Pram akrab dengan Niskala, Niskala jadi menabrak semua aturan yang telah disepakatinya dengan MELA, ibunya. Semua terasa benar sampai Ketika pram melihat niskala diberikan obat penenang oleh IBU dan sahabat niskala, Pram pun baru tahu kalau selama ini, Niskala diam-diam dari ayahnya yang protektif untuk melakukan aktifitasnya sosial dan meraih cita-citanya. Pram dan Niskala adalah dua pemuda yang sama-sama berharap suaranya "
        'Didengar'
        ', di dalam segala ketidakseimbangan hidup mereka, mereka menemukan keseimbangan itu saat saling mengisi satu sama lain.',
    imageAsset: "assets/kukira-kau-rumah.jpg",
  ),
  PlayModel(
    name: "SCREAM",
    genre: "Thriller, Mystery",
    duration: "1 Jam 54 Menit",
    director: "Matt Bettinelli-Olpin, Tyler Gillett",
    ageRating: "D17+",
    movieRating: "6.6",
    synopsis:
        "Dua puluh lima tahun setelah serangkaian pembunuhan berantai di Woodsboro, seorang pembunuh baru muncul, dan Sidney Prescott harus kembali lagi untuk mengungkap kebenaran.",
    imageAsset: "assets/scream.jpg",
  ),
  PlayModel(
    name: "MOONFALL",
    genre: "Action, Adventure, Fantasy",
    duration: "2 Jam 10 Menit",
    director: "Roland Emmerich",
    ageRating: "R13+",
    movieRating: "5.3",
    synopsis:
        "Sebuah kekuatan misterius menjatuhkan Bulan dari orbitnya dan akan menabrak bumi. Saat dunia di ambang kehancuran, mantan astronot NASA Jo Fowler (Halle Berry) yakin dia bisa menyelamatkan kita semua. Tetapi tidak semua orang mempercayainya, hanya mantan astronot Brian Harper (Patrick Wilson), dan ahli teori konspirasi, KC Houseman (John Bradley) yang bersedia membantunya. Mereka akan melakukan misi yang hampir mustahil ke luar angkasa, meninggalkan semua orang yang mereka cintai, untuk mengetahui bahwa Bulan tidak seperti yang kita pikirkan..",
    imageAsset: "assets/moonfall.jpg",
  ),
];
