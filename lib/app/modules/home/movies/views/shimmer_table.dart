import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTable extends StatelessWidget {
  const ShimmerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Match the table's background color
      body: Column(
        children: [
          // Shimmer for the table header
          Container(
            height: 50,
            color: Colors.transparent,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[700]!,
              child: Row(
                children: List.generate(
                  7, // Number of columns
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
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
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  height: 50,
                  color: Colors.transparent,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[700]!,
                    child: Row(
                      children: List.generate(
                        7, // Number of columns
                        (colIndex) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            height: 30,
                            color: Colors.grey[800], // Placeholder color
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShimmerTable(),
  ));
}