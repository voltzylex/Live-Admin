import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/Series/widgets/Series_data_source.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/views/edit_series_page.dart';

import '../models/series_model.dart';

class SeriesListPage extends StatefulWidget {
  const SeriesListPage({super.key, required this.series});
  final SeriesController series;

  @override
  State<SeriesListPage> createState() => _SeriesListPageState();
}

class _SeriesListPageState extends State<SeriesListPage> {
  // Handle toggle status
  void _toggleStatus(int id) {
    // Implement status toggle logic here
  }

  // Handle edit Series action
  void _editSeries(int id) {
    widget.series.id = id;
    // Get.to(() => EditSeriesPage(ser: widget.series), arguments: id);
    Get.find<DashboardController>().changePage(EditSeriesPage.name);
  }

  // Handle on Tap
  void _onTap(Series ser) {
    log("On Tap Called");
    // Get.to(SeriesDetailPage(series: ser));
  }

  // Handle delete Series action
  void _deleteSeries(int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted Series with ID: $id')),
    );
  }

  // Navigate to the next page
  void _nextPage(int lastPage) {
    if (widget.series.currenP.value < lastPage) {
      widget.series.currenP.value++;
    }
  }

  // Navigate to the previous page
  void _prevPage() {
    if (widget.series.currenP.value > 1) {
      widget.series.currenP.value--;
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

          // Series List Table with Pagination
          Expanded(
            child: widget.series.obx(
              (state) => _buildSeriesTable(state!),
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
          widget.series.obx(
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
            'Series',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        BaseButton(
          onPressed: () {
            widget.series.isUpload.toggle();
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
                  "Upload Series",
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeriesTable(SeriesModel state) {
    return Theme(
      data: ThemeData.dark(),
      child: PaginatedDataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 800,
        availableRowsPerPage: const [5, 10, 15],
        showCheckboxColumn: true,
        headingRowColor: MaterialStateProperty.all(AppColors.content),
        columns: const [
          DataColumn2(label: Text('ID'), size: ColumnSize.S),
          DataColumn2(label: Text('Series Name'), size: ColumnSize.L),
          DataColumn2(label: Text('Category'), size: ColumnSize.M),
          DataColumn2(label: Text('Type'), size: ColumnSize.M),
          DataColumn2(label: Text('Upload Date'), size: ColumnSize.M),
          DataColumn2(label: Text('Status'), size: ColumnSize.S),
          DataColumn2(label: Text('Actions'), size: ColumnSize.S),
        ],
        hidePaginator: true,
        source: SeriesDataSource(
          context,
          state.series,
          onEdit: _editSeries,
          onDelete: _deleteSeries,
          onToggleStatus: _toggleStatus,
          onTap: _onTap,
        ),
      ),
    );
  }

  Widget _buildPagination(SeriesModel state) {
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
                  text: '${state.series.length}',
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
                    widget.series.currenP.value = page;
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
