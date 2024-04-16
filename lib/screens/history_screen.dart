import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoty/controllers/quote_provider.dart';
import 'package:quoty/entities/quote.dart';

import '../widgets/small_quote_widget.dart';

List<Quote> dummyQuotes = [
  Quote("This is a first test quote", "Author 1"),
  Quote("This is a second test quote", "Author 2"),
  Quote("This is a third test quote", "Author 3"),
];

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: Provider.of<QuoteProvider>(context, listen: false).getAllQuotes(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Loading...'),);
            }
            else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: snapshot.data!.map((q) =>
                    Card(child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SmallQuoteWidget(quote: q,),
                    ))).toList(),
              );
            }
            return const Center(child: Text('Error.'),);
          }
        ),
      )),
    );
  }
}
