class Quote implements Comparable<Quote> {
  String quote;
  String author;
  String category = "";
  DateTime dateTime = DateTime.now();
  Quote(this.quote, this.author);

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
