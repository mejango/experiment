import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

class TokenCell extends StatelessWidget {
  final String ticker;
  final double balance;
  final double valuePerToken;
  final double issuance;
  final void Function()? onTap;

  TokenCell({
    required this.ticker,
    required this.balance,
    required this.valuePerToken,
    required this.issuance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    // Calculate total value
    final totalValue = balance * valuePerToken;

    // Ticker text
    final tickerText = Text(
      '\$${ticker}',
      style: theme?.typography?.title?.textStyle(
        color: theme.color?.text?.generalPrimary ?? Colors.black,
      ),
    );

    // Balance label (small and dim)
    final balanceLabel = Text(
      'Balance',
      style: theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.grey,
      ),
    );

    // Balance amount (large and prominent)
    final balanceAmount = Text(
      '\$${totalValue.toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: 32.0, // Make it really big
        fontWeight: FontWeight.bold,
        color: theme?.color?.text?.generalPrimary ?? Colors.white,
      ),
    );

    // Value per token label (small and dim)
    final valuePerTokenLabel = Text(
      'Token value',
      style: theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.grey,
      ),
    );

    // Value per token amount (large and prominent)
    final valuePerTokenAmount = Text(
      '\$${valuePerToken.toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: 24.0, // Big but smaller than balance
        fontWeight: FontWeight.bold,
        color: theme?.color?.text?.generalPrimary ?? Colors.white,
      ),
    );

    // Value per token unit (small and subtle)
    final valuePerTokenUnit = Text(
      'per \$${ticker}',
      style: TextStyle(
        fontSize: 12.0, // Small and subtle
        color: theme?.color?.text?.generalSecondary ?? Colors.grey,
      ),
    );

    // Token quantity label (small and dim)
    final tokenQuantityLabel = Text(
      'Current rewards',
      style: theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.grey,
      ),
    );

    // Token issuance amount (large and prominent)
    final tokenIssuanceAmount = Text(
      '${issuance.toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: 24.0, // Big but smaller than balance
        fontWeight: FontWeight.bold,
        color: theme?.color?.text?.generalPrimary ?? Colors.white,
      ),
    );

    // Token issuance unit (small and subtle)
    final tokenIssuanceUnit = Text(
      '\$${ticker} per USD',
      style: TextStyle(
        fontSize: 12.0, // Small and subtle
        color: theme?.color?.text?.generalSecondary ?? Colors.grey,
      ),
    );

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tickerText,
        Padding(
          padding: EdgeInsets.only(
            top: theme?.distance?.spacing?.vertical?.small ?? 0,
          ),
          child: balanceAmount,
        ),
        balanceLabel,
        Padding(
          padding: EdgeInsets.only(
            top: theme?.distance?.spacing?.vertical?.medium ?? 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              valuePerTokenAmount,
              SizedBox(width: 4.0),
              valuePerTokenUnit,
            ],
          ),
        ),
        valuePerTokenLabel,
        Padding(
          padding: EdgeInsets.only(
            top: theme?.distance?.spacing?.vertical?.medium ?? 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              tokenIssuanceAmount,
              SizedBox(width: 4.0),
              tokenIssuanceUnit,
            ],
          ),
        ),
        tokenQuantityLabel,
      ],
    );

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: column,
      ),
    );
  }
}
