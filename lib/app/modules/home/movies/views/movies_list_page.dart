import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/modules/home/movies/views/shimmer_table.dart';

class MoviesListPage extends StatefulWidget {
  const MoviesListPage({super.key, required this.mov});
  final MoviesController mov;

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  // final fetchMovie = widget.mov.movies;
  /*
  final List<Map<String, dynamic>> mockMovies = [
    {
      "id": 1,
      "name": "Inception",
      "category": "Sci-Fi",
      "type": "Feature Film",
      "uploadDate": "2023-12-01",
      "status": true,
    },
    {
      "id": 2,
      "name": "Interstellar",
      "category": "Adventure",
      "type": "Feature Film",
      "uploadDate": "2023-11-15",
      "status": false,
    },
    {
      "id": 3,
      "name": "Dune",
      "category": "Sci-Fi",
      "type": "Feature Film",
      "uploadDate": "2023-10-05",
      "status": true,
    },
  ];
*/
  void _toggleStatus(int id) {
    final fetch = widget.mov.movies.value;
    setState(() {
      final movie = fetch.firstWhere((movie) => movie.id == id);
      // movie["status"] = !movie["status"];
    });
  }

  void _editMovie(int id) {
    // Handle edit action (e.g., navigate to an edit screen)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit movie with ID: $id')),
    );
  }

  void _deleteMovie(int id) {
    setState(() {
      // mockMovies.removeWhere((movie) => movie["id"] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted movie with ID: $id')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Movies',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).paddingAll(20),
              BaseButton(
                onPressed: () {
                  widget.mov.isUpload.toggle();
                  // widget.mov.getMovies(1);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04, vertical: 10),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(kRadius)),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.white,
                      ),
                      Text(
                        "Upload Movie",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: widget.mov.obx((state) {
              return Theme(
                data: ThemeData.dark(),
                child: PaginatedDataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 800,
                  // autoRowsToHeight: true,
                  showCheckboxColumn: true,
                  // rowsPerPage: 5, // Number of rows per page
                  availableRowsPerPage: [5, 10, 15],
                  showFirstLastButtons: false,
                  headingRowColor: WidgetStateProperty.all(AppColors.content),
                  fixedColumnsColor: AppColors.red,
                  fixedCornerColor: AppColors.blue,

                  columns: [
                    const DataColumn2(
                      label: Text('ID'),
                      size: ColumnSize.S,
                    ),
                    const DataColumn2(
                      label: Text('Movie Name'),
                      size: ColumnSize.L,
                    ),
                    const DataColumn2(
                      label: Text('Category'),
                      size: ColumnSize.M,
                    ),
                    const DataColumn2(
                      label: Text('Type'),
                      size: ColumnSize.M,
                    ),
                    const DataColumn2(
                      label: Text('Upload Date'),
                      size: ColumnSize.M,
                    ),
                    const DataColumn2(
                      label: Text('Status'),
                      size: ColumnSize.S,
                    ),
                    const DataColumn2(
                      label: Text('Actions'),
                      size: ColumnSize.S,
                    ),
                  ],
                  source: _MovieDataSource(
                    context,
                    widget.mov.movies.value,
                    onEdit: _editMovie,
                    onDelete: _deleteMovie,
                    onToggleStatus: _toggleStatus,
                  ),
                ),
              );
            },
                onLoading: ShimmerTable(),
                onError: (error) => Text(error.toString())),
          ),
        ],
      ),
    );
  }
}

class _MovieDataSource extends DataTableSource {
  final BuildContext context;
  final List<Movie> movies;
  final void Function(int id) onEdit;
  final void Function(int id) onDelete;
  final void Function(int id) onToggleStatus;

  _MovieDataSource(
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
      specificRowHeight:
          movie.categories.length > 2 ? movie.categories.length * 21 : null,
      color: WidgetStateProperty.all(
          movie.id % 2 == 0 ? AppColors.table1 : AppColors.table2),
      cells: [
        DataCell(Text("#${movie.id}")),
        DataCell(FittedBox(
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
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: movie.categories
              .map(
                (e) => Text(
                  e.name,
                  textAlign: TextAlign.end,
                ),
              )
              .toList(),
        )),
        DataCell(Text(movie.title)),
        DataCell(Text(DateFormat('dd/MMM/yyyy')
            .format(movie.createdAt ?? DateTime.now()))),
        DataCell(Text("Hidden")),
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
  int get rowCount => movies.length;

  @override
  int get selectedRowCount => 0;
}
