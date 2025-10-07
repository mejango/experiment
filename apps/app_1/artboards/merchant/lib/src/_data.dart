import 'dart:async';

class TokenData {
  final String ticker;
  final double balance;
  final double valuePerToken;
  final double issuance;

  TokenData({
    required this.ticker,
    required this.balance,
    required this.valuePerToken,
    required this.issuance,
  });

  factory TokenData.fromMap(Map<String?, Object?> map) {
    return TokenData(
      ticker: map["ticker"] as String? ?? '',
      balance: (map["balance"] as num?)?.toDouble() ?? 0.0,
      valuePerToken: (map["valuePerToken"] as num?)?.toDouble() ?? 0.0,
      issuance: (map["issuance"] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class TokenDataProvider {
  Future<List<Object?>> get({
    required num pageSize,
    num pageNumber = 0,
    num startTimestamp = 0,
  }) async {
    // Return empty list since data is now in rowData
    return [];
  }
}
