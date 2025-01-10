import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/modules/home/series/models/series_model.dart';

class SeriesDataSource extends DataTableSource {
  final BuildContext context;
  final List<Series> series;
  final void Function(int id) onEdit;
  final void Function(int id) onDelete;
  final void Function(int id) onToggleStatus;

  SeriesDataSource(
    this.context,
    this.series, {
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  DataRow getRow(int index) {
    final seri = series[index];
    return DataRow2(
      // specificRowHeight:
      //     movie.categories.length > 2 ? movie.categories.length * 10 : null,
      color: WidgetStateProperty.all(
          seri.id % 2 == 0 ? AppColors.table1 : AppColors.table2),
      cells: [
        DataCell(Text("#${seri.id}")),
        DataCell(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 5,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(seri.poster),
              ),
              Text(seri.title),
            ],
          ),
        )),
        DataCell(Text(
          "categoreis",
          maxLines: 2,
        )),
        DataCell(Text(seri.title)),
        DataCell(Text(DateFormat('dd/MMM/yyyy')
            .format(seri.createdAt ?? DateTime.now()))),
        DataCell(Text(
          true ? "Visible" : "Hidden",
          style:
              TextStyle(color: true ? AppColors.green : AppColors.red),
        )),
        DataCell(FittedBox(
          child: Row(
            children: [
              SizedBox(
                height: 30,
                child: FittedBox(
                  child: Obx(
                    () => Switch(
                      value: MoviesController().to.isSwitchOn.value,
                      thumbColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.borderL1;
                        }
                        return AppColors.white;
                      }),
                      activeColor: AppColors.primary2,
                      trackOutlineColor:
                          WidgetStateProperty.all(AppColors.transparent),
                      inactiveTrackColor: Color(0xff506586),
                      // onChanged: (_) => onToggleStatus(movie["id"]),
                      onChanged: (value) =>
                          MoviesController().to.isSwitchOn(value),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.delete),
                // onPressed: () => onEdit(movie["id"]),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.edit),
                // onPressed: () => onDelete(movie["id"]),
                onPressed: () {},
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => series.length;

  @override
  int get selectedRowCount => 0;
}
