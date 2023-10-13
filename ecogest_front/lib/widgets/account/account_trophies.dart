import 'package:flutter/material.dart';
import 'package:ecogest_front/models/trophy_model.dart'; 
import 'package:ecogest_front/services/trophy_service.dart'; 

class AccountTrophies extends StatefulWidget {
  @override
  _AccountTrophiesState createState() => _AccountTrophiesState();
}

class _AccountTrophiesState extends State<AccountTrophies> {
  late Future<List<TrophyModel>> _trophiesFuture;

  @override
  void initState() {
    super.initState();
    _trophiesFuture = TrophyService.getTrophies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue-grey light border
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.blueGrey.shade200,
          ),
          SizedBox(height: 12),
          // Title "Mes accomplissements"
          Text(
            'Mes accomplissements',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          // List of trophies
          FutureBuilder<List<TrophyModel>>(
            future: _trophiesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading indicator or placeholder
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle error state
                return Text('Erreur de chargement des trophées: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // No trophies available
                return Text('Aucun trophée disponible.');
              } else {
                // Display the list of trophies
                return Column(
                  children: snapshot.data!.map((trophy) {
                    return _buildTrophyItem(trophy);
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

Widget _buildTrophyItem(TrophyModel trophy) {
  // Calculate the trophy number based on the current points
  int trophyNumber = (trophy.current_point! / 250).ceil();

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
  String imageLink = categoryImageMap[trophy.category_id] ?? 'default.png';

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
        SizedBox(width: 16),
        // Right: Text
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // Vous pouvez ajuster la couleur du texte si nécessaire
            ),
            children: [
              TextSpan(
                text: '$trophyNumber X ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '${_getCategoryName(trophy.category_id)}',
                style: TextStyle(
                  fontWeight: FontWeight.normal, // Laisse le reste du texte en style normal
                ),
              ),
            ],
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


}
