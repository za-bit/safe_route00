import 'package:flutter/material.dart';


import '../../model/user_dm.dart';
import '../utils/app_colors.dart';

class Profile extends StatelessWidget {
  static String routeName = "profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w300,
              fontSize: 30),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/dark3.png"), fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(
              flex: 50,
            ),
            Expanded(
                flex: 50,
                child: Column(
                  children: [
                    getRowOption("User Name", UserDM.currentUser!.userName),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      endIndent: 30,
                      indent: 30,
                      color: AppColors.textColor,
                    ),
                    getRowOption("Email", UserDM.currentUser!.email,),

                    Divider(
                      height: 1,
                      thickness: 0.5,
                      endIndent: 30,
                      indent: 30,
                      color: AppColors.textColor,
                    ),
                    getRowOption("Address", UserDM.currentUser!.address,),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      endIndent: 30,
                      indent: 30,
                      color: AppColors.textColor,
                    ),
                    getRowOption("Phone", UserDM.currentUser!.phone,),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

Widget getRowOption(String selectedOption,String selected ){
  return          Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Text(
              selectedOption,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),

        Text(
          selected,
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),

      ],
    ),
  );
}
