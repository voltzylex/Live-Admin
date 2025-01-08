// Import necessary libraries
import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/modules/home/movies/views/shimmer_table.dart';

// Main Movies List Page
class MoviesListPage extends StatelessWidget {
  const MoviesListPage({super.key, required this.controller});
  final MoviesController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        children: [
          _MoviesHeader(controller: controller),
          Expanded(
            child: controller.obx(
              (state) => MoviesDataTable(
                controller: controller,
                movies: state?.movies ?? [],
              ),
              onLoading: const ShimmerTable(),
              onError: (error) => Text(error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

// Movies Header Section
class _MoviesHeader extends StatelessWidget {
  const _MoviesHeader({required this.controller});
  final MoviesController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Movies',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).paddingAll(20),
        BaseButton(
          onPressed: () => controller.isUpload.toggle(),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: 10),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(kRadius),
            ),
            child: Row(
              spacing: 10,
              children: [
                const Icon(Icons.add, color: AppColors.white),
                const Text(
                  "Upload Movie",
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Movies Data Table
class MoviesDataTable extends StatefulWidget {
  const MoviesDataTable({
    super.key,
    required this.controller,
    required this.movies,
  });

  final MoviesController controller;
  final List<Movie> movies;

  @override
  State<MoviesDataTable> createState() => _MoviesDataTableState();
}

class _MoviesDataTableState extends State<MoviesDataTable> {
  @override
  void initState() {
    super.initState();
    log("init triggered");

    // Fetch the initial data (this ensures the table starts with data)
    // fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      log("Fetching initial data...");
      // Trigger a fetch to load the first page of data
      final initialMovies =
          await fetchMovies(1, 10); // Adjust `10` based on rowsPerPage
      if (initialMovies.isNotEmpty) {
        setState(() {
          // Optionally trigger state update if needed
        });
      }
    } catch (error) {
      log("Error fetching initial data: $error");
    }
  }

  Future<List<Movie>> fetchMovies(int page, int pageSize) async {
    try {
      log("Fetching movies for page: $page with pageSize: $pageSize");

      // Call the API to fetch movies
      final res = await ApiConnect.instance.getMovies(page);
      final movieModel = MoviesModel.fromJson(res.body);

      // Return a list of movies for the current page
      return movieModel.movies.take(pageSize).toList();
    } catch (error) {
      log("Error fetching movies: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: AsyncPaginatedDataTable2(
          controller: widget.controller.pageController,
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 800,
          availableRowsPerPage: const [2, 5, 10],
          rowsPerPage: 10,
          showCheckboxColumn: true,
          headingRowColor: WidgetStateProperty.all(AppColors.content),
          onPageChanged: (startIndex) {
            final page = (startIndex ~/ 10) + 1; // Calculate page number
            log("Page number $page");
            // controller.fetchMovies(page);
          },
          columns: const [
            DataColumn2(label: Text('ID'), size: ColumnSize.S),
            DataColumn2(label: Text('Movie Name'), size: ColumnSize.L),
            DataColumn2(label: Text('Category'), size: ColumnSize.M),
            DataColumn2(label: Text('Type'), size: ColumnSize.M),
            DataColumn2(label: Text('Upload Date'), size: ColumnSize.M),
            DataColumn2(label: Text('Status'), size: ColumnSize.S),
            DataColumn2(label: Text('Actions'), size: ColumnSize.S),
          ],
          source: MoviesAsyncDataSource(
            fetchMoviesCallback: (page, pageSize) =>
                fetchMovies(page, pageSize),
          )
          // _MovieDataSource(
          //   context: context,
          //   movies: widget.movies,
          //   onEdit: (id) => log("Edit movie with ID: $id"),
          //   onDelete: (id) => log("Delete movie with ID: $id"),
          //   onToggleStatus: (id) => log("Toggle status for ID: $id"),
          // ),
          ),
    );
  }
}

class MoviesAsyncDataSource extends AsyncDataTableSource {
  final Future<List<Movie>> Function(int page, int pageSize)
      fetchMoviesCallback;

  MoviesAsyncDataSource({required this.fetchMoviesCallback});

  int totalRecords = 0; // Total records fetched from API

  @override
  Future<AsyncRowsResponse> getRows(int start, int count) async {
    try {
      // Calculate the page number based on start and count
      final page = (start ~/ count) + 1;

      // Fetch movies for the current page
      final movies = await fetchMoviesCallback(page, count);

      // Set total records based on API response if available
      if (movies.isNotEmpty) {
        totalRecords = movies.length; // Assuming `totalRecords` is included
      }

      // Map movies to DataRows
      final rows = movies.map<DataRow>((movie) {
        return DataRow2(
          specificRowHeight:
              movie.categories.length > 2 ? movie.categories.length * 21 : null,
          cells: [
            DataCell(Text("#${movie.id}")),
            DataCell(FittedBox(
              child: Row(
                spacing: 5,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(movie.poster)),
                  Text(movie.title),
                ],
              ),
            )),
            DataCell(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: movie.categories.map((e) => Text(e.name)).toList(),
            )),
            DataCell(Text(movie.title ?? "N/A")),
            DataCell(Text(DateFormat('dd/MMM/yyyy').format(movie.createdAt!))),
            DataCell(Text("Hidden")),
            DataCell(Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => log("Edit movie: ${movie.id}"),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => log("Delete movie: ${movie.id}"),
                ),
              ],
            )),
          ],
        );
      }).toList();

      // Return rows as AsyncRowsResponse
      return AsyncRowsResponse(totalRecords, rows);
    } catch (error) {
      log("Error fetching rows: $error");
      return AsyncRowsResponse(0, []);
    }
  }
}
