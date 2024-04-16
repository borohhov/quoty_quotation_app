class Quote implements Comparable<Quote> {
  String quote;
  String author;
  String category = "";
  DateTime dateTime = DateTime.now();
  Quote(this.quote, this.author);

  Map<String, dynamic> toMap() => {
    'quote': quote,
    'author': author,
    'category': category,
    'dateTime': dateTime.toString()
  };

  factory Quote.fromMap(Map<String, dynamic> map) {
    Quote quote = Quote(
      map['quote'],
      map['author'],
    );
    quote.dateTime = DateTime.parse(map['dateTime']);
    quote.category = map['category'];
    return quote;
  }

  @override
  int compareTo(Quote other) {
      if(dateTime.isAfter(other.dateTime)) {
        return -1;
      }
      else if (dateTime.isBefore(other.dateTime)){
        return 1;
      }
      return 0;
    }
}
