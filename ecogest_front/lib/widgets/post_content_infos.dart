import 'package:flutter/material.dart';

class PostContentInfos extends StatelessWidget {
  const PostContentInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Column(
        children: [
          Text(
            'Ne pas manger de viande pendant une semaine',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '150',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(' points'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant,
                        size: 15,
                      ),
                      Text(' alimentation'),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  FilledButton(
                    onPressed: () {
                      // TODO : Afficher les défis
                    },
                    child: const Text(
                      'Défi',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            // TODO : Afficher la liste des publication avec ce #
                          },
                          child: const Text(
                            '#vegan',
                            style: TextStyle(color: Colors.black),
                          )),
                      TextButton(
                          onPressed: () {
                            // TODO : Afficher la liste des publication avec ce #
                          },
                          child: const Text(
                            '#nomeat',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      const Column(
        children: [
          Image(
            image: NetworkImage(
                'https://images.pexels.com/photos/1143754/pexels-photo-1143754.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            fit: BoxFit.cover,
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      )
    ]);
  }
}
