import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/modules/home/movies/widgets/add_movie_body.dart';
import 'package:live_admin/app/modules/home/movies/widgets/movie_data_source.dart';
import 'package:live_admin/app/utils/constants.dart';

class MoviesListPage extends StatefulWidget {
  const MoviesListPage({super.key, required this.mov});
  final MoviesController mov;

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  // Handle edit movie action
  void _editMovie(Movie movie) {
    log("Edit movie called ");

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.content, // Set a solid background color
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: AddMovieBody(
            mov: widget.mov,
            isEdit: true,
            movies: movie,
          ),
        ),
      ),
    );
  }

  // Handle delete movie action
  void _deleteMovie(Movie id) {
    showConfirmationDialog(
      context: context,
      title: "Confirm Deletion",
      content: "Are you sure you want to delete this movie?",
      onConfirm: () {
        widget.mov.deleteMovie(id.id, context);
      },
    );
  }

  // Navigate to the next page
  void _nextPage(int lastPage) {
    if (widget.mov.currenP.value < lastPage) {
      widget.mov.currenP.value++;
    }
  }

  // Navigate to the previous page
  void _prevPage() {
    if (widget.mov.currenP.value > 1) {
      widget.mov.currenP.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        children: [
          // Header Row with Title and Upload Button
          _buildHeader(),

          // Movie List Table with Pagination
          Expanded(
            child: widget.mov.obx(
              (state) => _buildMovieTable(state!),
              onLoading: const ShimmerTable(),
              onError: (error) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // Pagination Controls
          widget.mov.obx(
            (state) => _buildPagination(state!),
            onLoading: const SizedBox(height: 60),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: const Text(
            'Movies',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        BaseButton(
          onPressed: () {
            // widget.mov.isUpload.toggle();
            Get.dialog(
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.content, // Set a solid background color
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: AddMovieBody(
                    mov: widget.mov,
                  ),
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04,
              vertical: 10,
            ),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(kRadius),
            ),
            child: Row(
              children: [
                const Icon(Icons.add, color: AppColors.white),
                const SizedBox(width: 10),
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

  Widget _buildMovieTable(MoviesModel state) {
    return Theme(
      data: ThemeData.dark(),
      child: PaginatedDataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 800,
        rowsPerPage: 15,
        availableRowsPerPage: const [15],
        showCheckboxColumn: true,
        headingRowColor: WidgetStatePropertyAll(AppColors.content),
        columns: const [
          DataColumn2(label: Text('ID'), size: ColumnSize.S),
          DataColumn2(label: Text('Movie Name'), size: ColumnSize.L),
          DataColumn2(label: Text('Category'), size: ColumnSize.M),
          DataColumn2(label: Text('Type'), size: ColumnSize.M),
          DataColumn2(label: Text('Upload Date'), size: ColumnSize.M),
          DataColumn2(label: Text('Status'), size: ColumnSize.S),
          DataColumn2(label: Text('Actions'), size: ColumnSize.S),
        ],
        hidePaginator: true,
        source: MovieDataSource(
          context,
          // state.movies,
          widget.mov,
          onEdit: _editMovie,
          onDelete: _deleteMovie,
        ),
      ),
    );
  }

  Widget _buildPagination(MoviesModel state) {
    final currentPage = state.meta!.currentPage;
    final lastPage = state.meta!.lastPage;

    return Container(
      height: 60,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: AppColors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14).whiteColor,
              children: [
                const TextSpan(text: 'Showing '),
                TextSpan(
                  text: '${currentPage.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const TextSpan(text: ' to '),
                TextSpan(
                  text: '${state.movies.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const TextSpan(text: ' of '),
                TextSpan(
                  text: '${state.meta!.total}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const TextSpan(text: ' results'),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _prevPage(),
                icon: const Icon(Icons.navigate_before),
              ),
              ...List.generate(lastPage.toInt(), (index) {
                final page = index + 1;
                final isActive = page == currentPage;
                return GestureDetector(
                  onTap: () => setState(() {
                    widget.mov.currenP.value = page;
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.white : AppColors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      page.toString(),
                      style: AppTextStyles.base.copyWith(
                        color: isActive ? AppColors.primary : AppColors.white,
                      ),
                    ),
                  ),
                );
              }),
              IconButton(
                onPressed: () => _nextPage(lastPage.toInt()),
                icon: const Icon(Icons.navigate_next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
