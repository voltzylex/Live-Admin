import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/models/series_model.dart';
import 'package:live_admin/main.dart';

class SeriesDataSource extends DataTableSource {
  final BuildContext context;
  final List<Series> series;
  final void Function(int id) onEdit;
  final void Function(int id) onDelete;

  final void Function(Series ser) onTap;
  final SeriesController ser;
  SeriesDataSource(this.context, this.series,
      {required this.onEdit,
      required this.onDelete,
      required this.onTap,
      required this.ser});

  @override
  DataRow getRow(int index) {
    final seri = series[index];
    return DataRow2(
      // specificRowHeight:
      //     movie.categories.length > 2 ? movie.categories.length * 10 : null,
      onTap: () => onTap(seri),
      color: WidgetStateProperty.all(
          index % 2 == 0 ? AppColors.table1 : AppColors.table2),
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
          isTrue(seri.status) ? "Visible" : "Hidden",
          style: TextStyle(
              color: isTrue(seri.status) ? AppColors.green : AppColors.red),
        )),
        DataCell(FittedBox(
          child: Row(
            children: [
              SizedBox(
                height: 30,
                child: FittedBox(
                  child: Switch(
                    value: isTrue(seri.status),
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
                    onChanged: (value) =>
                        ser.toggleSeriesStatus(seri.id, value),
                  ),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.delete),
                onPressed: () => onDelete(seri.id),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.edit),
                onPressed: () => onEdit(seri.id),
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
