import 'package:flutter/material.dart';

class LobbyNavigation extends StatelessWidget{

  LobbyNavigation();

  @override
  Widget build(BuildContext context){
    return Container(
      child: IntrinsicHeight(
        child: Stack(
            children: [
              Image.asset('assets/images/lobby/lobby-navigation-block.png'),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {},
                        child: Image.asset('assets/images/lobby/lobby-navigation-goto-mystory.png'),
                      ),
                      GestureDetector(
                        onTap: () => {},
                        child: Image.asset('assets/images/lobby/lobby-navigation-goto-timechalenge.png'),
                      )
                    ],
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}