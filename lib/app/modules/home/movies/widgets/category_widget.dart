import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.categoryController,
    required this.mov,
  });
  final TextEditingController categoryController;
  final MoviesController mov;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // List to store selected categories

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TypeAheadField<String>(
          suggestionsCallback: (pattern) {
            return widget.mov.category
                .where((category) =>
                    category.toLowerCase().contains(pattern.toLowerCase()) &&
                    !widget.mov.selectedCategories
                        .contains(category)) // Exclude already selected
                .toList();
          },
          controller: widget.categoryController,
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Select category',
              ),
              validator: (value) {
                if (widget.mov.selectedCategories.isEmpty ) {
                  return "Please select Category";
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
            setState(() {
              widget.mov.selectedCategories
                  .add(suggestion); // Add selected category
              widget.categoryController.clear(); // Clear the input field
            });
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.mov.selectedCategories.map((category) {
            return Chip(
              label: Text(category),
              backgroundColor: AppColors.primary,
              labelStyle: const TextStyle(color: Colors.white),
              deleteIcon: const Icon(Icons.close, color: Colors.white),
              onDeleted: () {
                setState(() {
                  widget.mov.selectedCategories
                      .remove(category); // Remove the category
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
