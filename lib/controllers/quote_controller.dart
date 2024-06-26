import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:quoty/entities/quote.dart';

List<Quote> quotes = [
  Quote(
      "The greatest glory in living lies not in never falling, but in rising every time we fall.",
      "Nelson Mandela"),
  Quote("The way to get started is to quit talking and begin doing.",
      "Walt Disney"),
  Quote("Your time is limited, don't waste it living someone else's life.",
      "Steve Jobs"),
  Quote(
      "If life were predictable it would cease to be life, and be without flavor.",
      "Eleanor Roosevelt"),
  Quote(
      "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success.",
      "James Cameron"),
  Quote("Life is what happens when you're busy making other plans.",
      "John Lennon"),
  Quote(
      "Spread love everywhere you go. Let no one ever come to you without leaving happier.",
      "Mother Teresa"),
  Quote("When you reach the end of your rope, tie a knot in it and hang on.",
      "Franklin D. Roosevelt"),
  Quote(
      "Always remember that you are absolutely unique. Just like everyone else.",
      "Margaret Mead"),
  Quote(
      "Don't judge each day by the harvest you reap but by the seeds that you plant.",
      "Robert Louis Stevenson")
];

Future<Quote> getQuote({String category = ''}) async {
  String uri = 'https://quote-nry6mroyba-uc.a.run.app';
  if(category.isNotEmpty) {
    uri = '$uri?category=$category';
  }

  http.Request request =
      http.Request('get', Uri.parse(uri));

  http.StreamedResponse streamedResponse = await request.send();
  http.Response response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    Map<String, dynamic> json = Map();
    try {
      json = jsonDecode(response.body);
    }
    catch(e) {
      return Quote('Looks like the category is incorrect', 'Quoty');
  }
    Quote quote = Quote(json['quote'], json['author']);
    return quote;
  } else {
    // If the server did not return a 200 OK response,
    // get a random offline quote.
    return quotes[Random().nextInt(quotes.length - 1)];
  }
}
