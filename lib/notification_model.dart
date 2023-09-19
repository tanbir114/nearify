class notification_model {
  String? titel;
  String? date;
  String? thumbURL;

  notification_model(this.titel, this.date, this.thumbURL);

  static List<notification_model> notification_list = [
    // notification_model(
    //     'Regent 71 is available for rent Contact the owner for more details.',
    //     '29 July 2023',
    //     'assets/images/image7.png'),
    // notification_model('Jahangir Villa is unavailable for rent', '27 July 2023',
    //     'assets/images/image7.png'),
  ];
}
