import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget(
      {super.key, required this.typeController, required this.mov});
  final TextEditingController typeController;
  final MoviesController mov;
  @override
  Widget build(BuildContext context) {
    final mov = Get.find<MoviesController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TypeAheadField<String>(
          suggestionsCallback: (pattern) {
            return mov.type
                .where((type) =>
                    type.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          controller: typeController,
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Select type',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Please select Movie Type";
                }
                if (mov.type.contains(mov.selectedType.value) == false) {
                  return "Please select Movie Type from the list";
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
            typeController.text = suggestion;
            mov.selectedType.value = suggestion; // Save the selection
          },
        ),
      ],
    );
  }
}
