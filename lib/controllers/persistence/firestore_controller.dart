import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quoty/controllers/persistence/persistence_controller.dart';
import 'package:quoty/entities/quote.dart';

class FirestoreController implements PersistenceController {
  late FirebaseFirestore db;

  @override
  Future<void> addQuote(Quote quote) async {
    db.collection("quotes").add(quote.toMap());
  }

  @override
  Future<List<Quote>> getAllQuotes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("quotes").get();
    return snapshot.docs.map((doc) => Quote.fromMap(doc.data())).toList();
  }

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
    db = FirebaseFirestore.instance;
  }
}
