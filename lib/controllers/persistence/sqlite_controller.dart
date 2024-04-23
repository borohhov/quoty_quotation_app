import 'package:quoty/controllers/persistence/persistence_controller.dart';
import 'package:quoty/entities/quote.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteController implements PersistenceController {
  Database? _database;

  @override
  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'quotes.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT, author TEXT, category TEXT, dateTime TEXT)',
        );
      },
    );
  }

  @override
  Future<void> addQuote(Quote quote) async {
    await _database?.insert(
      'Quotes',
      {
        'quote': quote.quote,
        'author': quote.author,
        'category': quote.category,
        'dateTime': quote.dateTime.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Quote>> getAllQuotes() async {
    final List<Map<String, dynamic>> maps = await _database!.query('Quotes');

    return List.generate(maps.length, (i) {
      return Quote(
        maps[i]['quote'],
        maps[i]['author'],
      )
        ..category = maps[i]['category']
        ..dateTime = DateTime.parse(maps[i]['dateTime']);
    });
  }
}
