import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../model/user_dm.dart';
import '../home/home.dart';
import '../register/register.dart';
import '../utils/app_colors.dart';

class Login extends StatefulWidget {
  static String routeName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //    elevation: 0,
      //   title: Text("Login"),
      //   toolbarHeight: MediaQuery.of(context).size.height * .1,
      //   backgroundColor: Colors.transparent,
      //    centerTitle: true,
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),

              TextFormField(
                onChanged: (text) {email = text;},
                decoration: InputDecoration(
                  label: Text("Email"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),style: TextStyle(color: AppColors.textColor),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height * .2,),
              TextFormField(
                onChanged: (text) {password=text;},
                decoration: InputDecoration(
                  label: Text("Password"),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),style: TextStyle(color: AppColors.textColor),


                obscureText: true,
              ),
              SizedBox(
                height: 18,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(AppColors.primaryColor)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 9),
                  child: Text("Login",
                      style:
                      TextStyle(fontSize: 18, color: AppColors.textColor)),
                ),

              ),

              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Register.routeName);
                },
                child: Text("Creat account",
                    style: TextStyle(fontSize: 18, color: Colors.white70)),
              )
            ],
          ),
        ),
      ),
    );
  }
  void login() async {
    try {
      showLoading();
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserDM user=await getUserFromFirestore(credential.user!.uid);
      UserDM.currentUser=user;
      hideLoading();

      Navigator.pushReplacementNamed(context, Home.routeName);


    } on FirebaseAuthException catch (exception) {
      hideLoading();
      if (exception.code == "user-not-found") {
        showMyDialog(
            message:
            "Wrong email address please make sure you wrote right one!");
      } else if (exception.code == "wrong-password") {
        showMyDialog(
            dialogTitle: "Error",
            message: "Wrong password please make sure your wrote right one!");
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

  Future<UserDM> getUserFromFirestore(String uid) async {
    var usersCollection=  FirebaseFirestore.instance.collection("users");
    DocumentReference doc=usersCollection.doc(uid);
    DocumentSnapshot snapshot=await doc.get();
    Map json=snapshot.data() as Map;
    UserDM user=UserDM(uid, email, json["username"],json["address"],json["phone"]);
    return user;
  }
}
