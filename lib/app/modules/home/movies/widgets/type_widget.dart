import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';

class TypeWidget extends StatefulWidget {
  const TypeWidget({
    super.key,
    required this.typeController,
    required this.mov,
  });
  final TextEditingController typeController;
  final MoviesController mov;

  @override
  State<TypeWidget> createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {
  @override
  Widget build(BuildContext context) {
    final mov = Get.find<MoviesController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TypeAheadField<String>(
          suggestionsCallback: (pattern) {
            // Filter suggestions excluding already selected types
            return mov.type
                .where((type) =>
                    type.toLowerCase().contains(pattern.toLowerCase()) &&
                    !widget.mov.selectedTypes.contains(type))
                .toList();
          },
          controller: widget.typeController,
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Select type',
              ),
              validator: (value) {
                if (widget.mov.selectedCategories.isEmpty) {
                  return "Please select Movie Type";
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
              widget.mov.selectedTypes.add(suggestion); // Add the selected type
              widget.typeController.clear(); // Clear the input field
            });
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.mov.selectedTypes.map((type) {
            return Chip(
              label: Text(type),
              backgroundColor: AppColors.primary,
              labelStyle: const TextStyle(color: Colors.white),
              deleteIcon: const Icon(Icons.close, color: Colors.white),
              onDeleted: () {
                setState(() {
                  widget.mov.selectedTypes.remove(type); // Remove the type
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
