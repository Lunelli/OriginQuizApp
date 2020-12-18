class Answer {
  String questionId;
  String answerId;

  Answer({
    this.questionId,
    this.answerId,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'questionId': questionId,
        'answerId': answerId,
      };
}
