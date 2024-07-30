import 'dart:async';

import 'package:flutter/material.dart';


import '../../../../model/CarBump.dart';
import '../../../car_information/car_information.dart';
import '../../../profile/profile.dart';
import '../../../utils/app_colors.dart';
import 'dart:convert';


import 'package:http/http.dart' as http;

class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  StreamController<CarBump> streamController=StreamController();
  @override
  void dispose(){
    streamController.close();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getCarBump();
    });

  }


  Future<CarBump?> getCarBump() async {

    http.Response response = await http.get(Uri.parse("http://10.0.0.1:3000/bump"));
    var data=jsonDecode(response.body);
    CarBump carBump=CarBump.fromJson(data);
    streamController.sink.add(carBump);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: StreamBuilder<CarBump>(
          stream: streamController.stream,builder: (context,snapdata){
          switch(snapdata.connectionState){
            case ConnectionState.waiting:return Center(child: CircularProgressIndicator(),);
            default:if(snapdata.hasError){
              return Text('Please Wait...');
            }else{
              return BuildCoinWidget(snapdata.data!);
            }
          }
        },
        ),)
    );
  }
  Widget BuildCoinWidget(CarBump carBump){
    return Scaffold(backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //centerTitle: true,
        title: Text(
          "Setting",
          style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w300,
              fontSize: 30),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/dark2.png"), fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Profile.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            Icon(Icons.person,color: AppColors.textColor),
                            SizedBox(width: 5,),
                            Text("Profile",style: TextStyle(color: AppColors.textColor,fontSize: 18,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textColor,size: 18),

                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,endIndent: 30,indent: 30,
                  color: AppColors.textColor,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CarInfo.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            Icon(Icons.car_crash_outlined,color: AppColors.textColor),
                            SizedBox(width: 5,),
                            Text("Car Information",style: TextStyle(color: AppColors.textColor,fontSize: 18,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textColor,size: 18),

                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,endIndent: 30,indent: 30,
                  color: AppColors.textColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Icon(Icons.notification_add,color: AppColors.textColor),
                          SizedBox(width: 5,),
                          Text("Bump Notification",style: TextStyle(color: AppColors.textColor,fontSize: 18,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Text(
                        " ${carBump.bump}",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),

                      ),
                      Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textColor,size: 18),

                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
