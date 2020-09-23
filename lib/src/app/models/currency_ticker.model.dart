import 'dart:convert';

class CurrencyTicker {
  final double delay;
  final double recentMarketPprice;
  final double buyPrice;
  final double sellPrice;
  final String symbol;

  const CurrencyTicker({
    this.delay,
    this.recentMarketPprice,
    this.buyPrice,
    this.sellPrice,
    this.symbol,
  });

  Map<String, dynamic> toMap() {
    return {
      '15m': delay,
      'last': recentMarketPprice,
      'buy': buyPrice,
      'sell': sellPrice,
      'symbol': symbol,
    };
  }

  factory CurrencyTicker.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CurrencyTicker(
      delay: map['15m'],
      recentMarketPprice: map['last'],
      buyPrice: map['buy'],
      sellPrice: map['sell'],
      symbol: map['symbol'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyTicker.fromJson(String source) =>
      CurrencyTicker.fromMap(json.decode(source));
}
