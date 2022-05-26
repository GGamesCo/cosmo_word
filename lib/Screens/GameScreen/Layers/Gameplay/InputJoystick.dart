import 'package:event/event.dart';
import 'package:flutter/material.dart';

import '../../../../Flame/Models/Events/InputCompletedEventArgs.dart';

class InputJoystick extends StatelessWidget{

  final Event<InputCompletedEventArgs> userInputEvent;

  InputJoystick({required this.userInputEvent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: ElevatedButton(
              child: const Text('Send input'),
              onPressed: () {
                userInputEvent.broadcast(InputCompletedEventArgs('CLOUD'));
              },
            ),
          ),
        )
    );
  }
}