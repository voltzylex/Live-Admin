import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import 'package:live_admin/app/global_imports.dart';

class EndPoints {
  const EndPoints._();

  // static const String baseUrl = 'https://iptv.sunilflutter.in/api/';
  static const String baseUrl = 'https://iptv.justdemo.website/api/';
  static const String login = "admin/login";
  static const String user = "userdata";
  static const String addMovie = "admin/movies";
  static String getMovie(int page) => "movies?page=$page";
  static String updateMovie(String id) => "admin/movies/$id/update";
  static String deleteMovie(String id) => "admin/movies/$id";
  static String getSeries(int page) => "series?page=$page";
  static String getMemberships(int page) => "admin/myplans?page=$page";
  static String updateUser(String id) => "admin/users/$id";

  static const String getUser = "admin/users";
  static const Duration timeout = Duration(seconds: 30);

  static const String token = 'authToken';
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }

showLoading() {
  if (Get.isDialogOpen ?? false) {
    return;
  }
  Get.dialog(
    Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        child: SpinKitFadingCircle(
          color: AppColors.white,
          size: 50.0, // Adjust loader size
        )),
    barrierDismissible: false,
  );
}

hideLoading() {
  Get.back();
}

const List<String> movieCategories = [
  "Action",
  "Adventure",
  "Animation",
  "Biography",
  "Comedy",
  "Crime",
  "Documentary",
  "Drama",
  "Family",
  "Fantasy",
  "History",
  "Horror",
  "Musical",
  "Mystery",
  "Romance",
  "Science Fiction",
  "Sport",
  "Thriller",
  "War",
  "Western",
  "Superhero",
  "Noir",
  "Independent",
  "Disaster",
  "Historical Fiction",
  "Parody",
  "Epic",
  "Political",
  "Psychological",
  "Survival",
  "Slasher",
  "Dark Comedy",
  "Coming of Age",
  "Heist",
  "Spy",
  "Time Travel",
  "Cyberpunk",
  "Steampunk",
  "Space Opera",
  "Martial Arts",
  "Post-Apocalyptic",
  "Zombie",
  "Creature Feature",
  "Religious",
  "Detective",
  "Legal/Justice",
  "Romantic Comedy",
  "Satire",
  "Fantasy Adventure",
  "Science Fantasy",
  "War Drama",
  "Sword and Sorcery",
  "Road Movie",
  "Anthology",
  "Vampire",
  "Werewolf",
  "Supernatural Horror",
];
const List<String> movieTypes = [
  "Feature Film",
  "Short Film",
  "Documentary",
  "Series",
  "TV Show",
  "Mini-Series",
  "Animated Film",
  "Anthology",
  "Silent Film",
  "Stop-Motion Film",
  "3D Film",
  "Live-Action",
  "Mockumentary",
  "Web Series",
  "Experimental Film",
  "Musical Film",
  "Biography Film",
  "IMAX",
  "Direct-to-Video",
  "Streaming Exclusive",
  "Indie Film",
  "Made-for-TV",
  "Foreign Film",
  "Arthouse Film",
  "Blockbuster",
  "Fan Film",
  "Reboot",
  "Sequel",
  "Prequel",
  "Spin-off",
  "Found Footage",
  "Adaptation",
  "Docudrama",
  "Docuseries",
  "Reality Show",
  "Stage-to-Screen",
  "Motion Capture",
  "Interactive Film",
  "Children’s Film",
  "Holiday Film",
  "Film Noir",
  "Silent Film",
  "Satirical Film",
  "Claymation",
  "Animated Short",
  "Director’s Cut",
  "Supercut",
  "Compilation Film",
  "Travelogue",
];
