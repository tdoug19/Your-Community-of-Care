class ClientMeeting {
  final int day;
  final int month;
  final int year;
  final int hour;
  final int minute;
  final String description;

  ClientMeeting({
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
    required this.description,
  });

  factory ClientMeeting.fromJson(Map<String, dynamic> json) {
    return ClientMeeting(
      day: json['day'],
      month: (json['month']),
      year: json['year'],
      hour: json['hour'],
      minute: json['minute'],
      description: json['description'],
    );
  }

  toJson() {
    return {
      'day': day,
      'month': month,
      'year': year,
      'hour': hour,
      'minute': minute,
      'description': description,
    };
  }
}
