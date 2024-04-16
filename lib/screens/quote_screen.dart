import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoty/controllers/quote_controller.dart';
import 'package:quoty/controllers/quote_provider.dart';
import 'package:quoty/entities/quote.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return QuoteScreenState();
  }
}

class QuoteScreenState extends State<QuoteScreen> {
  late Future<Quote> futureQuote;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    futureQuote = getNewQuoteAndSave();
    super.initState();
  }

  Future<Quote> getNewQuoteAndSave() async {
    Quote quote = await getQuote(category: textEditingController.value.text);
    setState(() {});
    if (context.mounted) {
      Provider.of<QuoteProvider>(context, listen: false).addQuote(quote);
    }
    return quote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/history'),
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 12.0, bottom: 12, top: 12),
                child: Icon(Icons.history_edu_rounded),
              ),
            )
          ],
          title: Center(
            child: Text('Quoty'),
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), onPressed: getNewQuoteAndSave),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 60),
                child: FutureBuilder<Quote>(
                  future: futureQuote,
                  builder: (context, AsyncSnapshot<Quote> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      Quote quote = snapshot.data!;
                      return Column(
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
                                child: Text(
                                  '—${quote.author}',
                                  style: TextStyle(fontSize: 28),
                                ),
                              ))
                        ],
                      );
                    } else {
                      return Text('Couldn\'t get a quote...');
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                      onTap: getNewQuoteAndSave, child: Icon(Icons.search)),
                  // Use OutlineInputBorder for a box-like appearance
                  hintText:
                      'Enter a category', // Optional: Adds a label above the TextField
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
