import 'package:live_admin/app/global_imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTable extends StatelessWidget {
  const ShimmerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.content, // Match the table's background color
      body: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(kContentRadius)),
        child: Column(
          children: [
            // Shimmer for the table header
            Container(
              height: 50,
              color: Colors.transparent,
              child: Shimmer.fromColors(
                baseColor: AppColors.baseColor,
                highlightColor: AppColors.highlightColor,
                child: Row(
                  children: List.generate(
                    10, // Number of columns
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 30,
                        color: Colors.grey[800], // Placeholder color
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Shimmer for table rows
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Number of shimmer rows
                itemBuilder: (context, rowIndex) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    height: 50,
                    color: Colors.transparent,
                    child: Shimmer.fromColors(
                      baseColor: AppColors.baseColor,
                      highlightColor: AppColors.highlightColor,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: List.generate(
                            10, // Number of columns
                            (colIndex) => Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey[900]!, // Divider color
                                      width: 1,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const SizedBox.shrink(), // Placeholder
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
