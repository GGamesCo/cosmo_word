import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeAtackStage.dart';
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
                      getIt.get<StageManager>().navigateToStage(GameStage.Lobby, context);
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