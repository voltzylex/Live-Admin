import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({super.key, required this.typeController});
  final TextEditingController typeController;
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
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: typeController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Select type',
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
            typeController.text = suggestion;
            mov.selectedType.value = suggestion; // Save the selection
          },
        ),
      ],
    );
  }
}
