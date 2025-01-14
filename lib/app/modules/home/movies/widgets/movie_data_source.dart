import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class MovieDataSource extends DataTableSource {
  final BuildContext context;
  final MoviesController mov;
  final void Function(Movie movie) onEdit;
  final void Function(Movie movie) onDelete;

  MovieDataSource(
    this.context,
    this.mov, {
    required this.onEdit,
    required this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final movie = mov.state?.movies[index];
    if (movie == null) return DataRow(cells: []);

    return DataRow2(
      specificRowHeight: 50,
      color: WidgetStateProperty.all(
          index % 2 == 0 ? AppColors.table1 : AppColors.table2),
      cells: [
        DataCell(Text("#${movie.id}")),
        DataCell(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 5,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(Uri.parse(movie.poster).toString()),
              ),
              Text(movie.title),
            ],
          ),
        )),
        DataCell(Text(
          movie.categories.map((category) => category.name).join(', '),
          maxLines: 2,
        )),
        DataCell(Text(
          movie.tags.map((type) => type.name).join(', '),
          maxLines: 2,
        )),
        DataCell(Text(formatDateTime(movie.createdAt))),
        DataCell(Text(
          movie.status ? "Visible" : "Hidden",
          style:
              TextStyle(color: movie.status ? AppColors.green : AppColors.red),
        )),
        DataCell(FittedBox(
          child: Row(
            children: [
              SizedBox(
                height: 30,
                child: FittedBox(
                  child: Switch(
                    value: movie.status,
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
                    onChanged: (value) {
                      mov.toggleMovieStatus(movie.id, value); // Update status
                    },
                  ),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.delete),
                onPressed: () => onDelete(movie),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.edit),
                onPressed: () => onEdit(movie),
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
  int get rowCount => mov.state?.movies.length ?? 0;

  @override
  int get selectedRowCount => 0;
}
