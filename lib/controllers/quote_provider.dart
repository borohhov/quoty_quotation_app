import 'package:flutter/material.dart';

import '../entities/quote.dart';

class QuoteProvider extends ChangeNotifier {
  List<Quote> _quotes = [];
  void addQuote(Quote quote) {
    _quotes.add(quote);
    notifyListeners();
  }

  List<Quote> getAllQuotes() {
    _quotes.sort();
    return _quotes;
  }
}