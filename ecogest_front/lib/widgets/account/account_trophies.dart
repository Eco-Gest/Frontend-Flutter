import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTrophies extends StatelessWidget {
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
          // List of accomplishments
          _buildAccomplishmentItem('Accomplishment 1', 'assets/badges/alim.png'),
          _buildAccomplishmentItem('Accomplishment 2', 'assets/badges/biodiv.png'),
          _buildAccomplishmentItem('Accomplishment 1', 'assets/badges/dechets.png'),
          _buildAccomplishmentItem('Accomplishment 2', 'assets/badges/divers.png'),
          _buildAccomplishmentItem('Accomplishment 1', 'assets/badges/diy.png'),
          _buildAccomplishmentItem('Accomplishment 2', 'assets/badges/energie.png'),
          _buildAccomplishmentItem('Accomplishment 1', 'assets/badges/mobilite.png'),
          _buildAccomplishmentItem('Accomplishment 2', 'assets/badges/techno.png'),
          _buildAccomplishmentItem('Accomplishment 1', 'assets/badges/vie.png'),
          // Add more items as needed
        ],
      ),
    );
  }

  Widget _buildAccomplishmentItem(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Left: Picture
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          // Right: Text
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
