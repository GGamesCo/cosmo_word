import 'package:flutter/material.dart';

class StaticBackground extends StatelessWidget{

  final String fileName;

  StaticBackground({required this.fileName});

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/backgrounds/${this.fileName}')
        )
      ),
      child: Container(),
    );
  }
}