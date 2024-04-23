// Local Packages
import 'package:shopping_cart/data/page_items.dart';
import 'package:shopping_cart/data/app_state.dart';
import 'package:shopping_cart/pages/login.dart';

// Internet Packages
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

String? getCurrentUser() {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    return currentUser.displayName;
  }
  return null;
}

