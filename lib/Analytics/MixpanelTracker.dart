import 'package:injectable/injectable.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:random_name_plus/random_name_plus.dart';


@singleton
class MixpanelTracker {

  late Mixpanel mixpanel;

  Future<void> initAsync(String userId) async {
    mixpanel = await Mixpanel.init("143578392c79f4865d457b2c2bef510b", optOutTrackingDefault: false);
    //mixpanel.setLoggingEnabled(true);
    mixpanel.identify(userId);

    mixpanel.getPeople().setOnce("name", RandomName.generate(NameType.female));
  }

  void track(String eventName, {Map<String, Object>? params}){
    mixpanel.track(eventName, properties: params);
  }
}