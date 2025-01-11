import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/views/movies_list_page.dart';
import 'package:live_admin/app/modules/home/movies/widgets/add_movie_body.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mov = Get.put(MoviesController());

    return Obx(() {
      if (!mov.isUpload.value) {
        return MoviesListPage(
          mov: mov,
        );
      }
      return AddMovieBody(
        mov: mov,
      );
    });
  }
}
