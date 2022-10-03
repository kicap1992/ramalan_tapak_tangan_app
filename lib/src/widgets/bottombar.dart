import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../config/theme.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget(
      {Key? key, required this.indexSelected, required this.onTap})
      : super(key: key);

  final int indexSelected;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      // cornerRadius: 10,
      initialActiveIndex: indexSelected,
      disableDefaultTabController: true,
      backgroundColor: ThemeInfo.primary,
      items: [
        TabItem(
          icon: Icon(
            Icons.list_alt_outlined,
            color:
                (indexSelected == 0) ? ThemeInfo.primary : ThemeInfo.background,
          ),
          title: 'Ensiklopedia',
        ),
        TabItem(
          icon: Icon(
            Icons.photo_camera,
            color:
                (indexSelected == 1) ? ThemeInfo.primary : ThemeInfo.background,
          ),
          title: 'Garis Tangan',
        ),
        TabItem(
          icon: Icon(
            Icons.person_outline,
            color:
                (indexSelected == 2) ? ThemeInfo.primary : ThemeInfo.background,
          ),
          title: 'Profil',
        ),
      ],
      elevation: 1,
      onTap: (int index) {
        onTap(index);
      },
    );
  }
}
