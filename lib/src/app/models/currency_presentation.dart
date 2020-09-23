// A model class specifically for displaying data in a view. Everything is a
// preformatted string.
class CurrencyPresentation {
  final String flag;
  final String alphabeticCode;
  final String longName;
  String amount;

  CurrencyPresentation({
    this.flag,
    this.alphabeticCode,
    this.longName,
    this.amount,
  });
}
