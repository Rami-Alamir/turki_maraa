class Question {
  final String question;
  final String answer;

  Question({required this.question, required this.answer});
  factory Question.fromJson(Map<String, dynamic> json) =>
      Question(question: json["question"], answer: json["answer"]);
}
