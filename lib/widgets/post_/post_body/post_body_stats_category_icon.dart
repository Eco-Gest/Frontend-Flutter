import 'package:flutter/material.dart';

// PostBodyStatsCategoryIcon is part of the PostBodyStats widget.
// It displays an icon according to the category ID.

class PostBodyStatsCategoryIcon extends StatelessWidget {
  PostBodyStatsCategoryIcon({
    Key? key,
    required this.catId,
  }) : super(key: key);

  int? catId;

  @override
  Widget build(BuildContext context) {
    IconData iconToDisplay;
    if (catId == 1) {
      // 'Mobilité'
      iconToDisplay = Icons.pedal_bike;
    } else if (catId == 2) {
      // 'Alimentation'
      iconToDisplay = Icons.restaurant;
    } else if (catId == 3) {
      // 'Déchets'
      iconToDisplay = Icons.delete;
    } else if (catId == 4) {
      // 'Biodiversité'
      iconToDisplay = Icons.compost;
    } else if (catId == 5) {
      // 'Energie'
      iconToDisplay = Icons.bolt;
    } else if (catId == 6) {
      // 'Do It Yourself'
      iconToDisplay = Icons.handyman;
    } else if (catId == 7) {
      // 'Technologies'
      iconToDisplay = Icons.devices_other;
    } else if (catId == 8) {
      // 'Seconde vie'
      iconToDisplay = Icons.recycling;
    } else {
      // 'Divers' or a new category
      iconToDisplay = Icons.category_outlined;
    }
    return Icon(
      iconToDisplay,
      size: 15,
    );
  }
}
