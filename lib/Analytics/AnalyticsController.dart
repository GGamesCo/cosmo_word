import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@singleton
class AnalyticsController{
  static const WORD_INPUT = "wordInput";
  static const LEVEL_COMPLETED = "levelComplated";
  static const TIME_CHALLENGE_ENTER = "timeChallengeEnter";

  final UserController userController;

  AnalyticsController({required this.userController});

  Future<void> initAsync() async{
    await FirebaseAnalytics.instance
        .setDefaultEventParameters({
          "userId": userController.userId,
          "sessionId": userController.sessionId
    });
  }

  Future<void> logEventAsync(String eventName) async{
    await FirebaseAnalytics.instance.logEvent(name: eventName);
  }
}