import 'package:ecogest_front/views/users/trophies_view.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/models/trophy_model.dart';
import 'package:ecogest_front/services/trophy_service.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

class AccountTrophies extends StatefulWidget {
  AccountTrophies({Key? key, required this.userId});

  final int userId;

  @override
  _AccountTrophiesState createState() => _AccountTrophiesState();
}

class _AccountTrophiesState extends State<AccountTrophies> {
  late Future<List<TrophyModel>> _trophiesFuture;

  @override
  void initState() {
    super.initState();
    _trophiesFuture = TrophyService.getTrophies(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Blue-grey light border
        Container(
          width: double.infinity,
          height: 2,
          color: Colors.blueGrey.shade200,
        ),
        const SizedBox(height: 12),
        // Title "Mes accomplissements"
        const Text(
          'Accomplissements',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // List of trophies
        FutureBuilder<List<TrophyModel>>(
          future: _trophiesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading indicator or placeholder
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle error state
              return Text(
                  'Erreur de chargement des trophées: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // No trophies available
              return const Text('Aucun trophée disponible.');
            } else {
              // Display the list of trophies
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: _buildTrophyItems(snapshot.data!),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed(TrophiesView.name, extra: snapshot.data!);
                    },
                    child: const Text(
                      'Voir tous les trophées >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  List<Widget> _buildTrophyItems(List<TrophyModel> trophies) {
    // Count occurrences of each category ID
    Map<int, int> categoryCounts = {};
    for (int i = 0; i < trophies.length && i < 4; i++) {
      final TrophyModel trophy = trophies[i];
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
        ],
      ),
    );
  }
}
