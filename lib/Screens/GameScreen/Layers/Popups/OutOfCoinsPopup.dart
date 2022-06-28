import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Configs/PriceListConfig.dart';
import 'package:cosmo_word/Screens/Common/Story/MyStoryProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_dialog/native_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../Flame/StoryGame.dart';
import '../../../../GameBL/Common/Models/GameState.dart';
import '../../../../GameBL/Common/StageManager.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateModel.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateService.dart';
import '../../../../GameBL/Story/StoryStateController.dart';
import '../../../../di.dart';
import '../../../../main.dart';
import '../../GameScreen.dart';

class OutOfCoinsPopup extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AspectRatio(
          aspectRatio: 7 / 16,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset("assets/images/popups/popup-out-of_coins.png")),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.5, 0.45),
                      child: AspectRatio(
                        aspectRatio: 12 / 16,
                        child: Container(
                          //color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                            child: Container(
                              //color: Colors.blue,
                              child: Stack(
                                children: [
                                  Positioned(
                                        left: 90,
                                        top: 250,
                                        width: 130,
                                        height: 60,
                                        child:
                                    Container(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.orangeAccent, width: 4)
                                      // ),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                        ),
                                        onPressed: () {

                                          _onLoading(context);

                                          print("TODO: Add analytics on buy btn click");
                                        },
                                        child: Text(''),
                                      ),
                                    )
                                    ),
                                  Positioned(
                                      left: 0,
                                      top: 320,
                                      width: 290,
                                      height: 70,
                                      child:
                                      Container(
                                        // decoration: BoxDecoration(
                                        //     border: Border.all(color: Colors.orangeAccent, width: 4)
                                        // ),
                                        child: TextButton(
                                          style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(''),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: new Text("Initialize payment..."),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 1), () async {
      Navigator.pop(context); //pop dialog
      var storage = await getIt.getAsync<SharedPreferences>();
      final String compensationStringKey = "LastFreeHintsTime";
      var shouldFreeReward = true;
      if(storage.containsKey(compensationStringKey)){
        // One day left from last free reward.
         shouldFreeReward = DateTime.now().millisecondsSinceEpoch - storage.getInt("LastFreeHintsTime")! > 86400000;
      }

      if (shouldFreeReward){
        try {
          await getIt.get<IBalanceController>().addBalanceAsync(10 * PriceListConfig.HINT_PRICE);
          await NativeDialog.alert("Sorry, payments error occurred!\n10 hints reward COMPENSATION provided!");
          storage.setInt(compensationStringKey, DateTime.now().millisecondsSinceEpoch);
        } on PlatformException catch (error) {
          print(error.message);
        }
      }else{
        try {
          await NativeDialog.alert("Sorry, payments error occurred! Try again later!");
        } on PlatformException catch (error) {
          print(error.message);
        }
      }
    });
  }
}