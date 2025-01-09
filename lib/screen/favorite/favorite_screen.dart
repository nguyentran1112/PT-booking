import 'package:fitness/models/user_model.dart';
import 'package:fitness/screen/home_screen/partner_card.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Yêu thích',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  PartnerCard(
                    userModel: UserModel(
                        id: '1',
                        avatar: 'https://iili.io/2rBi3jR.jpg',
                        price: 4500000,
                        name: 'Nguyen Van A',
                        rating: 4.5),
                    algin: Algin.horizontal,
                  ),
                  if (index != 2) const Divider()
                ],
              );
            },
          ))
        ],
      ),
    ));
  }
}
