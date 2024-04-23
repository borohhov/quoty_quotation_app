import 'package:flutter/material.dart';
import 'package:quoty/controllers/persistence/firestore_controller.dart';
import 'package:quoty/controllers/persistence/persistence_controller.dart';
import 'package:quoty/controllers/persistence/sharedpreferences_controller.dart';
import 'package:quoty/controllers/persistence/sqlite_controller.dart';

import '../entities/quote.dart';

class QuoteProvider extends ChangeNotifier implements PersistenceController {
  PersistenceController persistence = FirestoreController();

  @override
  Future<void> init() async {
    persistence.init();
  }

  @override
  Future<void> addQuote(Quote quote) async {
    await init();
    persistence.addQuote(quote);
    notifyListeners();
  }

  @override
  Future<List<Quote>> getAllQuotes() async {
    await init();
    List<Quote> quotes = await persistence.getAllQuotes();
    quotes.sort();
    return quotes;
  }


}