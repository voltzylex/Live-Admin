import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';

class MovieDataSource extends DataTableSource {
  final BuildContext context;
  final List<Movie> movies;
  final void Function(Movie movie) onEdit;
  final void Function(Movie movie) onDelete;
  final void Function(int id) onToggleStatus;

  MovieDataSource(
    this.context,
    this.movies, {
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  DataRow getRow(int index) {
    final movie = movies[index];
    return DataRow2(
      specificRowHeight: 50,
      // movie.categories.length > 2 ? movie.categories.length * 12 : null,
      color: WidgetStateProperty.all(
          movie.id % 2 == 0 ? AppColors.table1 : AppColors.table2),
      cells: [
        DataCell(Text("#${movie.id}")),
        DataCell(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 5,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(movie.poster),
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
          movie.tags.map((category) => category.name).join(', '),
          maxLines: 2,
        )),
        DataCell(Text(DateFormat('dd/MMM/yyyy')
            .format(movie.createdAt ?? DateTime.now()))),
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
                // onPressed: () => onEdit(movie.id),
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
  int get rowCount => movies.length;

  @override
  int get selectedRowCount => 0;
}
