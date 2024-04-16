import 'package:quoty/entities/quote.dart';

abstract class PersistenceController {
  Future<void> init();
  Future<void> addQuote(Quote quote);
  Future<List<Quote>> getAllQuotes();
}