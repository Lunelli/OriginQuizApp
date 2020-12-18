class Question {
  String id;
  String question;
  //List<Map<String, String>> options;
  List options;

  Question({
    this.id,
    this.question,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: json['options'],
    );
  }
}
