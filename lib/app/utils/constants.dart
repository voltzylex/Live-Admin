import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import 'package:live_admin/app/global_imports.dart';

class EndPoints {
  const EndPoints._();

  // static const String baseUrl = 'https://iptv.sunilflutter.in/api/';
  static const String baseUrl = 'https://iptv.justdemo.website/api/';
  static const String login = "admin/login";
  static const String user = "userdata";
  static const String addMovie = "admin/movies";
  static const String dashboard = "admin/dashboard";
  static String getMovie(int page) => "movies?page=$page";
  static String updateMovie(String id) => "movies/$id/update";
  static String deleteMovie(String id) => "admin/movies/$id";
  static String getSeries(int page) => "series?page=$page";
  static String getSeiresById(int id) => "series/$id";
  static String getMemberships(int page) => "admin/myplans?page=$page";
  static String updateUser(String id) => "admin/users/$id";
  static String addUser = "register/user";
  static String deleteUser(int id) => "admin/users/$id";
  static String getPlans = "plans";
  static String getPlanHistory(int id) => "planhistory/$id";
  static String subscribe = "subscribe";
  static String addSeries = "store/series";
  static String editSeries(int id) => "update/series/$id";
  static String deleteSeries(int id) => "delete/series/$id";
  static String updateSeriesStatus(int id) => "update/seriesstatus/$id";

  static const String getUser = "admin/users";
  static const Duration timeout = Duration(seconds: 30);

  static const String token = 'authToken';
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }

String formatDateTime(DateTime? time) =>
    DateFormat('dd/MMM/yyyy').format(time ?? DateTime.now());
String formatToDate(DateTime date) => DateFormat("yyyy-MM-dd").format(date);
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

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.backgroundDark,
        title: Text(
          title,
          style: context.textTheme.bodyLarge,
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Execute the confirmed action
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
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
