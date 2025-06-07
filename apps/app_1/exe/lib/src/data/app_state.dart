import 'package:stream/index.dart';

class StreamableAppStateData extends StreamableData {
  bool isInSession;

  StreamableAppStateData({
    this.isInSession = false,
    super.key,
  });
}
