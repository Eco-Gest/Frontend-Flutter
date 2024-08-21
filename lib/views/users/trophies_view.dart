import 'package:ecogest_front/models/trophy_model.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class TrophiesView extends StatelessWidget {
  TrophiesView({Key? key, required this.trophies});

  static String name = 'trophies';

  final List<TrophyModel> trophies;

  List<Widget> _buildTrophyItems(List<TrophyModel> trophies) {
    // Count occurrences of each category ID
    Map<int, int> categoryCounts = {};
    for (var trophy in trophies) {
      int categoryId = trophy.category_id!;
      categoryCounts[categoryId] = (categoryCounts[categoryId] ?? 0) + 1;
    }

    // Build widgets based on counts
    return categoryCounts.entries.map((entry) {
      int categoryId = entry.key;
      int count = entry.value;

      return _buildCategoryItem(categoryId, count);
    }).toList();
  }

  Widget _buildCategoryItem(int categoryId, int count) {
    // Map category IDs to image links
    Map<int, String> categoryImageMap = {
      1: 'mobilite.png',
      2: 'alim.png',
      3: 'dechets.png',
      4: 'biodiv.png',
      5: 'energie.png',
      6: 'diy.png',
      7: 'techno.png',
      8: 'vie.png',
      9: 'divers.png',
    };

    // Get the image link based on category ID
    String imageLink = categoryImageMap[categoryId] ?? 'default.png';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Left: Picture
          Image.asset(
            'assets/trophy/$imageLink',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          // Right: Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: '$count X ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      _getCategoryName(categoryId),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2, // Maximum 2 lines
                      overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                      softWrap: true, // Allow text to wrap to the next line
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(int? categoryId) {
    // Map category IDs to category names
    Map<int, String> categoryNameMap = {
      1: 'As de la Mobilité Douce',
      2: 'Gourmand.e Responsable',
      3: 'Expert.e du Recyclage',
      4: 'Gardien.ne de la Nature',
      5: 'Génie de l\'Énergie',
      6: 'Pro du Bricolage',
      7: 'Magicien.ne des Technologies',
      8: 'Explorateur.trice de la Seconde Vie',
      9: 'Maître.sse des Gestes et Défis Divers',
    };

    // Get the category name based on category ID
    return categoryNameMap[categoryId] ?? 'Categorie inconnue';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Trophées'),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                children: _buildTrophyItems(trophies),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
