import 'package:data_table_2/data_table_2.dart';
import 'package:live_admin/app/global_imports.dart';

class MoviesListPage extends StatefulWidget {
  const MoviesListPage({super.key});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
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

  void _toggleStatus(int id) {
    setState(() {
      final movie = mockMovies.firstWhere((movie) => movie["id"] == id);
      movie["status"] = !movie["status"];
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
      mockMovies.removeWhere((movie) => movie["id"] == id);
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
          Row(),
          Expanded(
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 800,
              showCheckboxColumn: true,
              showHeadingCheckBox: true,
              dividerThickness: 0,
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
              rows: mockMovies.map((movie) {
                return DataRow(
                  onLongPress: () {},
                  color: WidgetStateProperty.all(movie["id"] % 2 == 0
                      ? AppColors.table1
                      : AppColors.table2),
                  cells: [
                    DataCell(Text(movie["id"].toString())),
                    DataCell(Text(movie["name"])),
                    DataCell(Text(movie["category"])),
                    DataCell(Text(movie["type"])),
                    DataCell(Text(movie["uploadDate"])),
                    DataCell(Text(movie["status"] ? "Active" : "Hiden")),
                    DataCell(
                        placeholder: true,
                        showEditIcon: true,
                        onTap: () => _editMovie(movie["id"]),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(useMaterial3: false),
                              child: Switch(
                                value: movie["status"],
                                onChanged: (_) => _toggleStatus(movie["id"]),
                              ),
                            ),
                            // IconButton(
                            //   icon: const Icon(Icons.edit, color: Colors.blue),
                            //   onPressed: () => _editMovie(movie["id"]),
                            // ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteMovie(movie["id"]),
                            ),
                          ],
                        )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
