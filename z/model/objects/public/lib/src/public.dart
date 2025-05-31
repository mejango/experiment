import 'package:key/index.dart' as _key;

class PublicCompletion {
  final String? who;
  final String? name;
  final String? roof;
  final String? note;

  PublicCompletion(
      {this.who, this.name, this.roof, this.note});

  factory PublicCompletion.fromMap(Map<String?, Object?> map) {
    return PublicCompletion(
      who: map[_key.who] as String?,
      name: map[_key.name] as String?,
      roof: map[_key.roof] as String?,
      note: map[_key.note] as String?,
    );
  }
}

class PublicExpense {
  final String? who;
  final String? note;
  final String? roof;

  PublicExpense({this.who, this.roof, this.note});

  factory PublicExpense.fromMap(Map<String?, Object?> map) {
    return PublicExpense(
      who: map[_key.who] as String?,
      roof: map[_key.roof] as String?,
      note: map[_key.note] as String?,
    );
  }
}

class PublicTransfer {
  final String? payer;
  final String? receiver;
  final String? note;
  final String? roof;

  PublicTransfer(
      {this.payer, this.receiver, this.roof, this.note});

  factory PublicTransfer.fromMap(Map<String?, Object?> map) {
    return PublicTransfer(
      payer: map[_key.payer] as String?,
      receiver: map[_key.receiver] as String?,
      roof: map[_key.roof] as String?,
      note: map[_key.note] as String?,
    );
  }
}

class PublicLandlordTransfer {
  final String? who;
  final String? home;
  final String? name;
  final String? note;
  final String? landlord;

  PublicLandlordTransfer(
      {this.who, this.home, this.name, this.landlord, this.note});

  factory PublicLandlordTransfer.fromMap(Map<String?, Object?> map) {
    return PublicLandlordTransfer(
      who: map[_key.who] as String?,
      home: map[_key.home] as String?,
      name: map[_key.name] as String?,
      landlord: map[_key.landlord] as String?,
      note: map[_key.note] as String?,
    );
  }
}

class PublicMaintenanceRequest {
  final String? who;
  final String? home;
  final String? name;
  final String? note;

  PublicMaintenanceRequest(
      {this.who, this.home, this.name, this.note});

  factory PublicMaintenanceRequest.fromMap(Map<String?, Object?> map) {
    return PublicMaintenanceRequest(
      who: map[_key.who] as String?,
      home: map[_key.home] as String?,
      name: map[_key.name] as String?,
      note: map[_key.note] as String?,
    );
  }
}
