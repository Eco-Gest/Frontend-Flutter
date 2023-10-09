import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
        
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Bloc: Profile Picture, Username, Location, Badge
        Row(
          children: [
            // Profile Picture (use Image.asset to load from assets)
            Container(
              width: 100, 
              height: 100, 
              //TODO vue si pas d'image 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/profile.jpg'), //TODO dynamic with api
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 40), 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.read<AuthenticationCubit>().state.user.username,  //TODO dynamic with api
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Location',  //TODO dynamic with api
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 12.0,
                  ), 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: EcogestTheme.primary,
                  ),
                  child: Text(
                    'Jeune Pousse', //TODO dynamic with api
                    style: TextStyle(fontSize: 14), 
                  ),
                ),

              ],
            ),
          ],
        ),
        SizedBox(height: 16), 
        // Second Bloc: Followings, Followers, Challenges Completed
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Followings', 
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '123',  //TODO dynamic with api
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  width: 1.0,
                  height: 60.0, 
                  color: Colors.blueGrey.shade400, 
                ),
                Column(
                  children: [
                    Text(
                      'Followers',  
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '456',  //TODO dynamic with api
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  width: 1.0, // Width of the border
                  height: 60.0, // Height of the border, adjust as needed
                  color: Colors.blueGrey.shade400, // Border color
                ),
                Column(
                  children: [
                    Text(
                      'Challenges', 
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '789',  //TODO dynamic with api
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
        SizedBox(height: 16), 
        // Third Bloc: Profile Bio
        Text(
          'Profile Bio Maecenas quis lacus id elit vehicula tempus. Vivamus hendrerit, dui sit amet fermentum mattis, purus odio vestibulum tortor, ac feugiat libero massa ut ex.',  //TODO dynamic with api
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
    ),
    );
  }
}
