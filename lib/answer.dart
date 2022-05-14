import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  
  final String answer;
  final VoidCallback callback;

  Answer(this.answer, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
       child: RaisedButton(
              child: Text(answer,
                    style: TextStyle(color: Colors.blue)),
              onPressed: callback,
            )
    );
  }
}