// Local Packages
import 'package:shopping_cart/functions/functions.dart';
import 'package:shopping_cart/data/page_items.dart';
import 'package:shopping_cart/data/app_state.dart';

// Internet Packages
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class ImageItem {
  final String image;
  final String title;
  final String description;
  final int price;

  ImageItem({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}

class foodPage extends StatelessWidget {
  String? userName = getCurrentUser();
  List<String> foodList;

  int pagenr;

  foodPage({
    super.key,
    required this.pagenr,
    required this.foodList,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(32, 30, 80, 69),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: topNavigationBar(title: foodList[pagenr]),

          ),
          body: FoodList(
            pagenr: pagenr,
          ),
          bottomNavigationBar: bottomNavigationBar(username: userName),
        );
      },
    );
  }
}
