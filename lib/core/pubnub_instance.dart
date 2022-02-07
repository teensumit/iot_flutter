import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iotflutter/core/app_init.dart';
import 'package:pubnub/networking.dart';
import 'package:pubnub/pubnub.dart';

class PubNubInstance {
  late PubNub _pubnub;
  late Subscription _subscription;

  PubNub get instance => _pubnub;

  Subscription get subscription => _subscription;

  PubNubInstance() {
    _pubnub = PubNub(
        networking: NetworkingModule(retryPolicy: RetryPolicy.exponential()),
        defaultKeyset: Keyset(
            subscribeKey: dotenv.env['PUBNUB_SUBSCRIBE_KEY']!,
            publishKey: dotenv.env['PUBNUB_PUBLISH_KEY'],
            uuid: UUID("iot_flutter")));

    _subscription =
        _pubnub.subscribe(channels: {"IOT_FLUTTER"}, withPresence: true);
    _subscription.resume();
  }

  void resume() => _subscription.resume();
}
