import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
class TAnimation extends StatefulWidget {
  const TAnimation({super.key});

  @override
  State<TAnimation> createState() => _TAnimationState();
}
class _TAnimationState extends State<TAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 44, 42, 42),
      body: Stack(
        children: [
          ClipPath(
            clipper: Containerclipper(),
            child: Container(
              color: Color.fromARGB(255, 87, 83, 83),
              height: double.infinity,
              width: 200,
            ),
          ),
          Stack(
            children: [
              Row(
                children: [
                  const Spacer(),
                  ClipPath(
                    clipper: Container2clipper(),
                    child: Container(
                      color: Color.fromARGB(255, 87, 83, 83),
                      height: double.infinity,
                      width: 150,
                    ),
                  ),
                ], ),
            ],
          )  ],
      ),
    );
  }
}
class Containerclipper extends CustomClipper<Path>{
  var path=Path();
  var x;
  var y;
  @override
  Path getClip(Size size) {
    path.lineTo((size.width/2)-10, 0);
    path.quadraticBezierTo(size.width-200, size.height*0.5, (size.width/2)+40, size.height);
    path.lineTo((size.width/2)+40,size.height );
    path.lineTo(0,size.height );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>false;

}
class Container2clipper extends CustomClipper<Path>{
  var path=Path();
  var z;
  var i;
  @override
  Path getClip(Size size) {
    path.moveTo(size.width,0);
    path.lineTo(size.width-100,0 );
    path.quadraticBezierTo(size.width-200, size.height*0.5, size.width-50, size.height);
    path.lineTo(size.width-50,size.height );
    path.lineTo(size.width,size.height );
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>true;

}
Widget buildDaheLine()=>Center(
  child: DottedLine(
    direction: Axis.vertical,
    dashColor: Colors.white,
    dashGapLength: 30,
    dashLength: 16,
    dashGapRadius: 80,
    lineThickness: 16,
  ),
);