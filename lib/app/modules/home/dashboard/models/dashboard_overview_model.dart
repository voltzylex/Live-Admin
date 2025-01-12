import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart';

class DashboardOverviewModel {
  final String title;
  final SvgPicture image;
  final Color color;

  DashboardOverviewModel({
    required this.title,
    required this.image,
    required this.color,
  });
}
final List<DashboardOverviewModel> overviewData = [
  DashboardOverviewModel(
    title: "User",
    image: SvgPicture.asset(Assets.user),
    color: Color(0xFF21C4FF), // Hex color converted to Flutter's Color
  ),
  DashboardOverviewModel(
    title: "Movies",
    image: SvgPicture.asset(Assets.movie),
    color: Color(0xFF2CD8BA),
  ),
  DashboardOverviewModel(
    title: "Active Members",
    image: SvgPicture.asset(Assets.member),
    color: Color(0xFF9D00D4),
  ),
];
