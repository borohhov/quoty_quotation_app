import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:quoty/entities/quote.dart';

class SmallQuoteWidget extends StatelessWidget {
  const SmallQuoteWidget({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quote.quote,
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        Text(
          '—${quote.author}',
          style: TextStyle(fontSize: 16),
        ),
        Text('Created: ${DateFormat.yMMMd().format(quote.dateTime)}')
      ],
    );
  }
}
