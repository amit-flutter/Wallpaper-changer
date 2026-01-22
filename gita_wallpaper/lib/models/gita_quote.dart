class GitaQuote {
  final String quote;
  final String chapter;
  final String verse;

  GitaQuote({
    required this.quote,
    required this.chapter,
    required this.verse,
  });

  factory GitaQuote.fromJson(Map<String, dynamic> json) {
    return GitaQuote(
      quote: json['quote'] ?? '',
      chapter: json['chapter'] ?? '',
      verse: json['verse'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'chapter': chapter,
      'verse': verse,
    };
  }
}
