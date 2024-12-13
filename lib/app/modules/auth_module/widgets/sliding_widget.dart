import 'package:flutter/material.dart';
import 'package:live_admin/app/utils/assets.dart';

class SlidingImage extends StatefulWidget {
  const SlidingImage({super.key});

  @override
  State<SlidingImage> createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _pageController.animateToPage(
    //     1,
    //     duration: const Duration(seconds: 10),
    //     curve: Curves.easeIn,
    //   );
    // });
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Set duration for smooth sliding
    )..repeat(); // Repeat the animation indefinitely

    // Define the animation to animate the image from bottom to top
    _animation = Tween<double>(
      begin: 0.0, // Start at the initial position
      end: 1.0, // End when the first image has fully scrolled off
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRect(
      child: TickerMode(
        enabled: true,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                // First image
                Transform.translate(
                  // Slide the first image from bottom to top
                  offset: Offset(0, screenHeight * _animation.value),
                  child: child,
                ),
                // Second image follows the first
                Transform.translate(
                  // Move the second image immediately after the first one
                  offset: Offset(0, screenHeight * (_animation.value - 1)),
                  child: child,
                ),
              ],
            );
          },
          child: Image.asset(
            Assets.frame,
            height: screenHeight, // Ensure the image height covers the screen
            width: MediaQuery.of(context).size.width *
                0.7, // Ensure it covers the screen width
            fit: BoxFit.cover, // Adjust image to cover the screen area properly
          ),
        ),
      ),
    );
    // return SizedBox(
    //   width: MediaQuery.of(context).size.width * 0.7,
    //   height: screenHeight,
    //   child: CarouselSlider(
    //     items: [
    //       Image.asset(
    //         Assets.assetsImagesLoginBg,
    //         height: screenHeight, // Ensure the image height covers the screen
    //         width: MediaQuery.of(context).size.width *
    //             0.7, // Ensure it covers the screen width
    //         fit: BoxFit.cover, // Adjust image to cover the screen area properly
    //       ),
    //       Image.asset(
    //         Assets.assetsImagesLoginBg,
    //         height: screenHeight, // Ensure the image height covers the screen
    //         width: MediaQuery.of(context).size.width *
    //             0.7, // Ensure it covers the screen width
    //         fit: BoxFit.cover, // Adjust image to cover the screen area properly
    //       ),
    //     ],
    //     options: CarouselOptions(
    //       autoPlay: true,
    //       autoPlayInterval: const Duration(seconds: 5),
    //       autoPlayAnimationDuration: const Duration(seconds: 20),
    //       autoPlayCurve: Curves.easeIn,
    //       enableInfiniteScroll: true,
    //       scrollDirection: Axis.vertical,
    //     ),
    //   ),
    // );
    // return SizedBox(
    //   width: MediaQuery.of(context).size.width * 0.7,
    //   child: PageView.builder(
    //     scrollDirection: Axis.vertical,
    //     itemBuilder: (context, index) {
    //       return Image.asset(
    //         Assets.assetsImagesLoginBg,
    //         height: screenHeight, // Ensure the image height covers the screen
    //         width: MediaQuery.of(context).size.width *
    //             0.6, // Ensure it covers the screen width
    //         fit: BoxFit.cover, // Adjust image to cover the screen area properly
    //       );
    //     },
    //     itemCount: 2,
    //     controller: _pageController,
    //     onPageChanged: (value) {
    //       if (value == 1) {
    //         _pageController.animateToPage(
    //           0,
    //           duration: const Duration(seconds: 10),
    //           curve: Curves.easeIn,
    //         );
    //       } else if (value == 0) {
    //         _pageController.animateToPage(
    //           1,
    //           duration: const Duration(seconds: 10),
    //           curve: Curves.easeIn,
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
