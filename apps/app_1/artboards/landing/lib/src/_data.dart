import 'dart:async';

class Merchant {
  final String? name;
  final int? createdAt;
  final String? logoUri;
  final int section; // 0 for "Recently shopped", 1 for "Top shops around you"
  final String? ticker; // Token ticker for this merchant

  Merchant({
    this.name, 
    this.createdAt, 
    this.logoUri,
    required this.section,
    this.ticker,
  });

  factory Merchant.fromMap(Map<String?, Object?> map) {
    return Merchant(
      name: map["name"] as String?,
      createdAt: map["createdAt"] as int?,
      logoUri: map["logoUri"] as String?,
      section: map["section"] as int? ?? 0,
      ticker: map["ticker"] as String?,
    );
  }
}

class Merchants {
  Future<List<Object?>> get({
    required num pageSize,
    num pageNumber = 0,
    num startTimestamp = 0,
  }) async {
    // Return empty list since data is now in rowData
    return [];
  }
}



