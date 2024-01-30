class QuoteModel {
  final String quote;
  final String author;
  final String category;

  QuoteModel({
    required this.quote,
    required this.author,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "quote": quote,
      "author": author,
      "category": category,
    };
  }

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['quote'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
