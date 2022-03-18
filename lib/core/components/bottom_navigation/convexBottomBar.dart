import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class ConvexBottomBar extends StatelessWidget {
  ConvexBottomBar({required this.onTap,required this.selectedIndex, Key? key}) : super(key: key);
  void Function(int)? onTap;
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      items: [
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.home)
      ],
      onTap: onTap,
      initialActiveIndex: selectedIndex,
    );
  }
}
