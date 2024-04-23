// Local Packages
import 'package:shopping_cart/pages/login.dart';
import 'package:shopping_cart/functions/functions.dart';
import 'package:shopping_cart/data/app_state.dart';

// Internet Packages
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Database reference
final DatabaseReference orderCounter = FirebaseDatabase.instance.ref();

Map<int, int> countList = {};

class ImageItem {
  final String image;
  final String title;
  final String description;
  final int price;
  int count = 0;

  ImageItem({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}

class topNavigationBar extends StatelessWidget {
  String? title;

  topNavigationBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(32, 30, 80, 69),
      title: Text(
        title!,
        style: const TextStyle(
          color: Color.fromRGBO(223, 248, 235, 3),
        ),
      ),
    );
  }
}

class bottomNavigationBar extends StatelessWidget {
  final String? username;

  bottomNavigationBar({required this.username});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      height: 56,
      color: const Color.fromRGBO(32, 30, 80, 69),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${appState.totalPrice} lei',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              username!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    //appState.resetPrice();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )))
        ],
      ),
    );
  }
}

var page;

class FoodList extends StatelessWidget {
  int? pagenr;

  FoodList({
    required this.pagenr,
  });

  Map<int, List<ImageItem>> imageList = {
    0: [
      ImageItem(
        image: 'assets/images/ciorbe/ciorba_de_vacuta.jpg',
        title: 'Ciroba de vacuta',
        price: 18,
        description:
            'carne de vită, legume (cartofi, morcovi, țelină, ardei gras, ceapă, fasole verde), apă, borș, pastă de tomate,ulei de floarea soarelui, leuștean, sare',
      ),
      ImageItem(
        image: 'assets/images/ciorbe/ciorba_gulas_2.jpg',
        title: 'Ciorba Gulas',
        price: 20,
        description:
            'carne de vită, ceapă, ardei kapia, cartofi, boia iute, boia dulce, pastă de tomate, semințe de chimen, ulei de floarea soarelui, sare, piper, leuștean,  servit cu pâine prăjită',
      ),
      ImageItem(
        image: 'assets/images/ciorbe/ciorba_supa_crema_de_rosii_1.jpg',
        title: 'Ciorba Supa Crema',
        price: 25,
        description:
            'roșii decojite, cremă vegetală pt gătit, usturoi, brânză grana duro, telemea cuburi,  busuioc fresh, sare, piper, servită cu pâine prăjită gratinată cu brânză grana duro',
      ),
    ],
    1: [
      ImageItem(
        image: 'assets/images/pizza/pizza_con_gamberi_1.jpeg',
        title: 'Pizza con gamberi',
        price: 41,
        description:
            'blat de pizza, sos de roșii, brânză mozarella, rosii cherry, creveți decorticați, busuioc fresh',
      ),
      ImageItem(
        image: 'assets/images/pizza/pizza_capriciosa_1.jpg',
        title: 'Pizza Capricioasa',
        price: 45,
        description:
            'blat de pizza, sos de roșii, brânză mozzarella, șuncă Praga, măsline, ciuperci',
      ),
      ImageItem(
        image: 'assets/images/pizza/pizza_nostra_1.jpg',
        title: 'Pizza Nostra',
        price: 39,
        description:
            'blat de pizza, sos de roșii,  brânză mozzarella, șuncă Praga, salam crud uscat, măsline, ardei gras, ciuperci, ou ochi',
      ),
      ImageItem(
        image: 'assets/images/pizza/pizza_torino_2.jpg',
        title: 'Pizza Torino',
        price: 43,
        description:
            'blat de pizza, sos de roșii, brânză mozzarella, piept de pui, roșii uscate, rucola, brânză grana duro',
      ),
    ],
    2: [
      ImageItem(
        image: 'assets/images/carne/pui/piept_de_pui_nou_1.jpeg',
        title: 'Piept de pui nou',
        price: 28,
        description: 'piept de pui , sare, piper',
      ),
      ImageItem(
        image: 'assets/images/carne/pui/snitel_parmigiana_pui_1.jpg',
        title: 'Snitel Pui Parmigiana',
        price: 30,
        description:
            'piept de pui, ou, muștar, făină de grâu, pesmet panko, brânză mozzarella, brânză grana duro, sos de roșii,  busuioc fresh, sare, piper, gratinat ',
      ),
      ImageItem(
        image: 'assets/images/carne/porc/porc_cotlet_haiducesc_1.jpg',
        title: 'Cotlet Haiducesc de porc',
        price: 40,
        description: 'cotlet de porc, sare, piper',
      ),
      ImageItem(
        image: 'assets/images/carne/porc/porc_snitel.jpeg',
        title: 'Snitel de porc',
        price: 49,
        description:
            'cotlet de porc, ou, muștar, făină de grâu, pesmet Panko, mix salată, roșii cherry, brânză grana duro, sare, piper',
      ),
      ImageItem(
        image: 'assets/images/carne/vita/vita_muschi_de_vita_la_gratar_1.jpg',
        title: 'Muschi de vita la gratar',
        price: 51,
        description: 'mușchi de vită, sare, piper, ',
      ),
      ImageItem(
        image: 'assets/images/carne/vita/vita_muschi_pane.jpeg',
        title: 'Vita Muschi pane',
        price: 36,
        description:
            'mușchi de vită, ciuperci de pădure, cognac, unt, brânză grana duro, busuioc fresh, ulei de măsline extra virgin, sare, piper',
      ),
      ImageItem(
        image: 'assets/images/carne/vita/vita_snitel_elefante_1.jpg',
        title: 'Snitel Elefante',
        price: 39,
        description:
            'mușchi de vită, ou, muștar, făină  de grâu, pesmet panko, brânză mozzarella, roșii, brânză grana duro, rucola, sare, piper, gratinat',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageList[pagenr]?.length,
      itemBuilder: (context, index) {
        page = imageList[pagenr]?[index];
        return GestureDetector(
          onTap: () {
            _openImageDetails(context, imageList, pagenr!, index);
          },
          child: SizedBox(
            height: 400,
            child: Stack(
              children: [
                Image.asset(
                  page!.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      '${page.price} lei',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        page.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _openImageDetails(
    BuildContext context, dynamic imageList, int pagenr, int index) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      page = imageList[pagenr]?[index];
      return Container(
        color: const Color.fromRGBO(32, 30, 80, 69),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              page.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Price: ${page.price} lei',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              page.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            CounterButton(page: page, index: index),
          ],
        ),
      );
    },
  );
}

class CounterButton extends StatefulWidget {
  final page;
  int index;

  CounterButton({
    super.key,
    required this.page,
    required this.index,
  });

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    orderCounter.onValue.listen(
      (event) {
        setState(() {
          countList[widget.index] = int.parse(event.snapshot.value.toString());
        });
      },
    );

    if (countList[widget.index] == null) {
      countList[widget.index] = 0;
      orderCounter.child("orderCounter").child(widget.index.toString()).set(
        {"value": 0},
      );
    }

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              appState.incrementTotalPrice(widget.page.price);
              countList[widget.index] = (countList[widget.index]! + 1)!;
              orderCounter
                  .child("orderCounter")
                  .child(widget.index.toString())
                  .update(
                {"value": countList[widget.index]},
              );
            });
          },
        ),
        Text(
          countList[widget.index].toString(),
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (countList[widget.index]! > 0) {
                appState.decrementTotalPrice(widget.page.price);
                countList[widget.index] = (countList[widget.index]! - 1)!;
                orderCounter
                    .child("orderCounter")
                    .child(widget.index.toString())
                    .update(
                  {"value": countList[widget.index]},
                );
              }
            });
          },
        ),
      ],
    );
  }
}
