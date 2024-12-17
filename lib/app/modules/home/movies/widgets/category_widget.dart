import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.categoryController, required this.mov});
  final TextEditingController categoryController;
  final MoviesController mov;
  @override
  Widget build(BuildContext context) {
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
          controller: categoryController,
          
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Select category',
                // border: OutlineInputBorder(),
                // errorBorder: OutlineInputBorder(),
                // enabledBorder: OutlineInputBorder(),
                // focusedBorder: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Please select Category";
                }
                if (mov.category.contains(mov.selectedCategory.value) ==
                    false) {
                  return "Please select category from the list";
                }
                return null;
              },
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
