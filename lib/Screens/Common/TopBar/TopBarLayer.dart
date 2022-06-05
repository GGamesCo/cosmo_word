import 'package:flutter/material.dart';

import '../../LobbyScreen/LobbyScreen.dart';

class TopBarLayer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      child: ElevatedButton(
        child: const Text('<-'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LobbyScreen()),
          );
        },
      ),
    );
  }
}