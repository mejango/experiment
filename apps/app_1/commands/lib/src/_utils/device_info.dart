import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';

class DeviceInfo {
  final String? os;
  final String? version;
  final String? hardware;
  final String? manufacturer;
  final String? id;
  final String? type;
  final String? platform;
  final String? agent;

  DeviceInfo._internal({
    this.os,
    this.version,
    this.hardware,
    this.manufacturer,
    this.id,
    this.type,
    this.platform,
    this.agent,
  });

  static Future<DeviceInfo> read() async {
    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;

      return DeviceInfo._internal(
        os: iosInfo.systemName,
        version: iosInfo.systemVersion,
        hardware: iosInfo.model,
        manufacturer: "Apple",
        id: iosInfo.identifierForVendor,
        type: "mobile",
        platform: "ios",
        agent: iosInfo.systemName + " " + iosInfo.systemVersion + " " + iosInfo.model + " " + iosInfo.identifierForVendor,
      );
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo =
          await DeviceInfoPlugin().androidInfo;

      return DeviceInfo._internal(
        os: androidDeviceInfo.version.baseOS,
        version: androidDeviceInfo.version.release,
        hardware: androidDeviceInfo.device,
        manufacturer: androidDeviceInfo.manufacturer,
        id: androidDeviceInfo.id,
        type: "mobile",
        platform: "android",
        agent: androidDeviceInfo.version.release + " " + androidDeviceInfo.device + " " + androidDeviceInfo.id + " " + androidDeviceInfo.manufacturer + " " + (androidDeviceInfo.version.baseOS ?? ""),
      );
    } else if (Platform.isMacOS) {
      return DeviceInfo._internal(
        os: "macOS",
        version: Platform.operatingSystemVersion,
        hardware: Platform.localHostname,
        manufacturer: "Apple Inc.",
        id: "",
        type: "desktop",
        platform: "browser",
        agent: "macOS " + Platform.operatingSystemVersion,
      );
    } else {
      print("Device info not available");

      return DeviceInfo._internal();
    }
  }

  Map<String, String> toMap() {
    return {
      "os": os ?? "",
      "version": version ?? "",
      "hardware": hardware ?? "",
      "manufacturer": manufacturer ?? "",
      "id": id ?? "",
      "type": type ?? "",
      "platform": platform ?? "",
      "agent": agent ?? "",
    };
  }
}
