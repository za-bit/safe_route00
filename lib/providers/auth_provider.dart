import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_dm.dart';

// class AuthProvider extends ChangeNotifier{
//   UserDM? currrentUser;
//   void updateUser(UserDM LoggedInUser){
//     currrentUser=LoggedInUser;
//     notifyListeners();
//
//   }
//   bool isUserLoggedInBefore() {
//     return FirebaseAuth.instance.currentUser != null;
//      // Navigator.pushReplacementNamed(context, Login.routeName);
//
//
//
//   }
//}