import 'package:flutter/material.dart';
import 'package:quoty/controllers/persistence/persistence_controller.dart';
import 'package:quoty/controllers/persistence/sharedpreferences_controller.dart';

import '../entities/quote.dart';

class QuoteProvider extends ChangeNotifier implements PersistenceController {
  PersistenceController persistence = SharedPreferencesController();

  @override
  Future<void> init() async {
    // noop
  }

  Future<void> addQuote(Quote quote) async {
    //_quotes.add(quote);
    persistence.addQuote(quote);
    notifyListeners();
  }

  Future<List<Quote>> getAllQuotes() async {
    List<Quote> quotes = await persistence.getAllQuotes();
    quotes.sort();
    return quotes;
  }


}