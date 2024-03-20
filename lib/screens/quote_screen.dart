import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quoty/controllers/quote_controller.dart';
import 'package:quoty/entities/quote.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return QuoteScreenState();
  }


}

class QuoteScreenState extends State<QuoteScreen> {
  late Quote quote;

  @override
  void initState() {
    quote = getQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Quoty'),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            quote = getQuote();
          });
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote.quote,
                      style: TextStyle(
                        fontSize: 36,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text('—${quote.author}',
                            style: TextStyle(fontSize: 28),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                  // Use OutlineInputBorder for a box-like appearance
                  hintText:
                  'Enter something', // Optional: Adds a label above the TextField
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}
