// Local Packages
import 'package:shopping_cart/functions/functions.dart';
import 'package:shopping_cart/data/app_state.dart';
import 'package:shopping_cart/data/page_items.dart';
import 'package:shopping_cart/pages/foodPage.dart';

// Internet Packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  final dynamic user;

  const MainPage({super.key, this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? userName = getCurrentUser();


  final List<String> foodList = ["Ciorbe","Pizza","Carne","Gustari","Bauturi","Deserturi"];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(32, 30, 80, 69),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: topNavigationBar(title: "Main Page",),
        ),
        body: NavigationContainer(
          foodList: foodList,
        ),
        bottomNavigationBar: bottomNavigationBar(username: userName),
      ),
    );
  }
}

class NavigationContainer extends StatelessWidget {
  final List<String> foodList;

  final int buttonCount = 6; // Number of buttons to create

  const NavigationContainer({
    super.key,
    required this.foodList,
  });


  // 25 +

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: buttonCount,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => foodPage(pagenr: index,foodList: foodList)),
            );
          },
          child: Container(
            color: const Color.fromRGBO(194, 255, 133, 100),
            child: Center(
              child: Text(
                foodList[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}