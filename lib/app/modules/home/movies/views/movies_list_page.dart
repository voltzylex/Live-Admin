import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/utils/widgets/app_button/base_button.dart';

class MoviesListPage extends StatefulWidget {
  const MoviesListPage({super.key});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  @override
  Widget build(BuildContext context) {
    final mv = MoviesController().to;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Movies",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BaseButton(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(10).copyWith(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Upload movie",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  // Get.toNamed()
                  mv.isUpload.toggle();
                },
              ),
            ],
          ).paddingAll(20)
        ],
      ),
    );
  }
}
