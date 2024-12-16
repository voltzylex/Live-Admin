import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.categoryController});
  final TextEditingController categoryController;
  @override
  Widget build(BuildContext context) {
    final mov = Get.find<MoviesController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TypeAheadField<String>(
          suggestionsCallback: (pattern) {
            return mov.category
                .where((category) =>
                    category.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          builder: (context, controller, focusNode) {
            return TextField(
              controller: categoryController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Select category',
                border: OutlineInputBorder(),
              ),
            );
          },
          itemBuilder: (context, String suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSelected: (String suggestion) {
            categoryController.text = suggestion;
            mov.selectedCategory.value = suggestion; // Save the selection
          },
        ),
      ],
    );
  }
}
