import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../model/user_dm.dart';
import '../home/home.dart';
import '../utils/app_colors.dart';

class Register extends StatefulWidget {
  static String routeName = "register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String username="";
  String address="";
  String phone="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text("Register"),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              TextFormField(
                onChanged: (text) {username=text;},
                decoration: InputDecoration(
                  label: Text("user name"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),
                style: TextStyle(color: AppColors.textColor),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: InputDecoration(
                  label: Text("Email"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),
                style: TextStyle(color: AppColors.textColor),
              ),
              TextFormField(
                onChanged: (text) {
                  address = text;
                },
                decoration: InputDecoration(
                  label: Text("Address"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),
                style: TextStyle(color: AppColors.textColor),
              ),
              TextFormField(
                onChanged: (text) {
                  phone = text;
                },
                decoration: InputDecoration(
                  label: Text("Phone"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),
                style: TextStyle(color: AppColors.textColor),
              ),



              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: InputDecoration(
                  label: Text("Password"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),
                style: TextStyle(color: AppColors.textColor),

                obscureText: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(AppColors.primaryColor)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Text(
                      "Creat account",
                      style: TextStyle(fontSize: 18,color: AppColors.textColor),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    try {
      showLoading();
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await saveUserInFireStore(email,username,credential.user!.uid,address,phone);
      hideLoading();
      UserDM.currentUser=UserDM(credential.user!.uid, email, username,address,phone);

      Navigator.pushNamed(context, Home.routeName);

    } on FirebaseAuthException catch (exception) {
      hideLoading();
      if (exception.code == "weak-password") {
        showMyDialog(
            message:
            "Weak password. Please try another one with character length more 6");
      } else if (exception.code == 'email-already-in-use') {
        showMyDialog(
            dialogTitle: "Error",
            message: "This email is already in use please try another one");
      } else {
        showMyDialog();
      }
    }
  }

  void showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(children: [
              Text("Loading .. "),
              Spacer(),
              CircularProgressIndicator()
            ]),
          );
        },
        barrierDismissible: false);
  }

  void hideLoading() {
    Navigator.pop(context);
  }

  void showMyDialog(
      {String? dialogTitle,
        String message = "something went wrong, Please try again later"}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: dialogTitle == null ? SizedBox() : Text(dialogTitle),
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ok"))
          ],
        );
      },
    );
  }
  Future saveUserInFireStore(String email,String userName,String uid,String address,String phone) async {
    CollectionReference usersCollection=FirebaseFirestore.instance.collection("users");
    DocumentReference userDocument=usersCollection.doc(uid);
    return userDocument.set({
      "id":uid,
      "email":email,
      "username":username,
      "address":address,
      "phone":phone,

    });
  }
}
