import 'dart:convert';

import 'package:kanyimax/src/app/models/currency_ticker.model.dart';

class BlockchainTicker {
  final CurrencyTicker usd;
  final CurrencyTicker aud;
  final CurrencyTicker brl;
  final CurrencyTicker cad;
  final CurrencyTicker chf;
  final CurrencyTicker clp;
  final CurrencyTicker cny;
  final CurrencyTicker dkk;
  final CurrencyTicker eur;
  final CurrencyTicker gbp;
  final CurrencyTicker hkd;
  final CurrencyTicker inr;
  final CurrencyTicker isk;
  final CurrencyTicker jpy;
  final CurrencyTicker krw;
  final CurrencyTicker nzd;
  final CurrencyTicker pln;
  final CurrencyTicker rub;
  final CurrencyTicker sek;
  final CurrencyTicker sgd;
  final CurrencyTicker thb;
  final CurrencyTicker kTry;
  final CurrencyTicker twd;

  const BlockchainTicker({
    this.usd,
    this.aud,
    this.brl,
    this.cad,
    this.chf,
    this.clp,
    this.cny,
    this.dkk,
    this.eur,
    this.gbp,
    this.hkd,
    this.inr,
    this.isk,
    this.jpy,
    this.krw,
    this.nzd,
    this.pln,
    this.rub,
    this.sek,
    this.sgd,
    this.thb,
    this.kTry,
    this.twd,
  });

  Map<String, dynamic> toMap() {
    return {
      'USD': usd?.toMap(),
      'AUD': aud?.toMap(),
      'BRL': brl?.toMap(),
      'CAD': cad?.toMap(),
      'CHF': chf?.toMap(),
      'CLP': clp?.toMap(),
      'CNY': cny?.toMap(),
      'DKK': dkk?.toMap(),
      'EUR': eur?.toMap(),
      'GBP': gbp?.toMap(),
      'HKD': hkd?.toMap(),
      'INR': inr?.toMap(),
      'ISK': isk?.toMap(),
      'JPY': jpy?.toMap(),
      'KRW': krw?.toMap(),
      'NZD': nzd?.toMap(),
      'PLN': pln?.toMap(),
      'RUB': rub?.toMap(),
      'SEK': sek?.toMap(),
      'SGD': sgd?.toMap(),
      'THB': thb?.toMap(),
      'TRY': kTry?.toMap(),
      'TWD': twd?.toMap(),
    };
  }

  factory BlockchainTicker.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BlockchainTicker(
      usd: CurrencyTicker.fromMap(map['USD']),
      aud: CurrencyTicker.fromMap(map['AUD']),
      brl: CurrencyTicker.fromMap(map['BRL']),
      cad: CurrencyTicker.fromMap(map['CAD']),
      chf: CurrencyTicker.fromMap(map['CHF']),
      clp: CurrencyTicker.fromMap(map['CLP']),
      cny: CurrencyTicker.fromMap(map['CNY']),
      dkk: CurrencyTicker.fromMap(map['DKK']),
      eur: CurrencyTicker.fromMap(map['EUR']),
      gbp: CurrencyTicker.fromMap(map['GBP']),
      hkd: CurrencyTicker.fromMap(map['HKD']),
      inr: CurrencyTicker.fromMap(map['INR']),
      isk: CurrencyTicker.fromMap(map['ISK']),
      jpy: CurrencyTicker.fromMap(map['JPY']),
      krw: CurrencyTicker.fromMap(map['KRW']),
      nzd: CurrencyTicker.fromMap(map['NZD']),
      pln: CurrencyTicker.fromMap(map['PLN']),
      rub: CurrencyTicker.fromMap(map['RUB']),
      sek: CurrencyTicker.fromMap(map['SEK']),
      sgd: CurrencyTicker.fromMap(map['SGD']),
      thb: CurrencyTicker.fromMap(map['THB']),
      kTry: CurrencyTicker.fromMap(map['TRY']),
      twd: CurrencyTicker.fromMap(map['TWD']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockchainTicker.fromJson(String source) =>
      BlockchainTicker.fromMap(json.decode(source));
}
