class Result {
  String statement;
  int hitPercentage;

  Result({
    this.statement = '',
    this.hitPercentage = 0,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      statement: json['statement'],
      hitPercentage: json['hitPercentage'],
    );
  }
}
