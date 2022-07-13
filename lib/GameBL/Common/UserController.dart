import 'package:cosmo_word/di.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

@singleton
class UserController{
  static const String UserIdKey = "userId";

  late String userId;
  late String sessionId;

  Future<void> initAsync() async{
      var storage = getIt.get<SharedPreferences>();

      if (!storage.containsKey(UserIdKey)){
        print("User not found. Creating new user");
        var newUserId = Uuid().v1();
        storage.setString(UserIdKey, newUserId);
      }

      userId = storage.getString(UserIdKey)!;
      sessionId = Uuid().v1();

      print("UserId: ${userId}");
      print("SessionId: ${sessionId}");
  }
}