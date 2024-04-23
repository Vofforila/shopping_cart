import 'package:flutter/foundation.dart';



class AppState extends ChangeNotifier {
  int _totalPrice = 0;
  int _count = 0;

  int get totalPrice => _totalPrice;
  int get count => _count;

  void incrementTotalPrice(int price) {
    _totalPrice = _totalPrice +  price;
    notifyListeners();
  }

  void decrementTotalPrice(int price) {
    _totalPrice = _totalPrice - price;
    notifyListeners();
  }

  void incrementCount() {
    _count++;
    notifyListeners();
  }

  void decrementCount() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }

  void resetPrice() {
    _totalPrice = 0;
    notifyListeners();
  }

}
