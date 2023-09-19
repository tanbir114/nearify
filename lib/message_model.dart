class message_model {
  String? name;
  int messageCount;
  List<String> message;
  String? thumbURL;

  message_model(this.name, this.messageCount, this.message, this.thumbURL);

  static List<message_model> message_list = [
    message_model(
        'Khalid Hassan Chowdhury',
        2,
        ['okey thank you. I will let you know if i rent your apartment', 'bye'],
        'assets/images/image7.png'),
    message_model(
        'Farooq Hasan',
        1,
        ['okey thank you. I will let you know if i rent your apartment'],
        'assets/images/image7.png'),
  ];
}
