import 'dart:convert';

import 'package:quoty/controllers/persistence/persistence_controller.dart';
import 'package:quoty/entities/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController implements PersistenceController {
  late SharedPreferences prefs;
  static const String _quotesKey = 'quotes';
  @override
  Future<void> addQuote(Quote quote) async {
    await init();
    final List<Quote> quotes = await getAllQuotes(); // Retrieve current list of quotes
    quotes.add(quote); // Add new quote to list
    // Convert all quotes to JSON and store them
    List<String> jsonQuotes = quotes.map((q) => json.encode(q.toMap())).toList();
    await prefs.setStringList(_quotesKey, jsonQuotes);
  }

  @override
  Future<List<Quote>> getAllQuotes() async {
    await init();
    List<String> jsonQuotes = prefs.getStringList(_quotesKey) ?? [];
    return jsonQuotes.map((q) => Quote.fromMap(json.decode(q))).toList();
  }

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}