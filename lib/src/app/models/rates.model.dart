import 'dart:convert';

class Rate {
  // Use an ISO alphabetic code.
  final String baseCurrency;

  // Use an ISO alphabetic code.
  final String quoteCurrency;

  final double exchangeRate;

  Rate({this.baseCurrency, this.quoteCurrency, this.exchangeRate}) {
  //   if (baseCurrency.length != 3 || quoteCurrency.length != 3)
  //     throw ArgumentError('The ISO code must have a length of 3.');
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      baseCurrency: map['baseCurrency'],
      quoteCurrency: map['quoteCurrency'],
      exchangeRate: map['exchangeRate'],
    );
  }

  factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source));
}
