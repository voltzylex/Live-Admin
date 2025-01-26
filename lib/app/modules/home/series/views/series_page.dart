
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/widgets/add_series_page.dart';
import 'package:live_admin/app/modules/home/series/widgets/series_list_page.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ser = Get.put(SeriesController());



    return Obx(() {
      if (!ser.isUpload.value) {
        return SeriesListPage(
          series: ser,
        );
      }
      return AddSeriesPage(
        ser: ser,
      );
   
    });
  }
}
