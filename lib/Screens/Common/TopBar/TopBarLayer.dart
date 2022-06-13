import 'package:cosmo_word/GameBL/TimeChallenge/TimeGameController.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/material.dart';

import '../../LobbyScreen/LobbyScreen.dart';
import 'BalanceIndication.dart';

class TopBarLayer extends StatelessWidget{

  final bool showBack;
  final bool showSettings;
  final bool showBalance;

  TopBarLayer({
    required this.showBack,
    required this.showSettings,
    required this.showBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if(showBack) ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          getIt.get<TimeGameController>().terminateGame();
                          return LobbyScreen();
                        }),
                      );
                    },
                    child: Image.asset('assets/images/common_controls/backBtn.png'),
                  )
                ],
                if(showSettings) ...[
                  GestureDetector(
                    onTap: () => {},
                    child: Image.asset('assets/images/common_controls/settingsBtn.png'),
                  )
                ]
              ],
            ),
            if(showBalance) ...[
              BalanceIndication()
            ]
          ],
        ),
      ),
    );
  }
}