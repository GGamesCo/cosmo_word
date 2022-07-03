import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/AlertDialog.dart';
import 'package:cosmo_word/GameBL/Configs/PriceListConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../di.dart';

class OutOfCoinsPopup extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AspectRatio(
          aspectRatio: 7.5 / 16,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(

                                    onTap: () => _onBuyClick(context),
                                    child: SizedBox(width: MediaQuery.of(context).size.width/2, child: Image.asset('assets/images/popups/buy-btn.png')),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(width: MediaQuery.of(context).size.width/8, child: Image.asset('assets/images/popups/close-buy-btn.png')),
                                  )
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

  void _onBuyClick(BuildContext context) {
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

      var analyticsController = getIt.get<AnalyticsController>();
      var storage = await getIt.getAsync<SharedPreferences>();
      final String compensationStringKey = "LastFreeHintsTime";
      var shouldFreeReward = true;
      if(storage.containsKey(compensationStringKey)){
        // One day left from last free reward.
         shouldFreeReward = DateTime.now().millisecondsSinceEpoch - storage.getInt("LastFreeHintsTime")! > 86400000;
      }

      if (shouldFreeReward){
        try {
          analyticsController.logEventAsync(AnalyticEvents.BUY_HINTS_CLICK, params: {"compensation" : true});

          await getIt.get<IBalanceController>().addBalanceAsync(5 * PriceListConfig.HINT_PRICE);
          await showAlertDialog(context, "Error", "Sorry, payments error occurred!\n5 hints reward COMPENSATION provided!");
          storage.setInt(compensationStringKey, DateTime.now().millisecondsSinceEpoch);
        } on PlatformException catch (error) {
          print(error.message);
        }
      }else{
        try {
          analyticsController.logEventAsync(AnalyticEvents.BUY_HINTS_CLICK, params: {"compensation" : false});

          await showAlertDialog(context, "Error", "Sorry, payments error occurred! Try again later!");
        } on PlatformException catch (error) {
          print(error.message);
        }
      }
    });
  }
}