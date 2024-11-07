class Alert {
  final String name;
  final String bBoxName;
  final String alert;

  Alert({
    required this.name,
    required this.bBoxName,
    required this.alert,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      name: json['name'],
      bBoxName: json['b_box_name'],
      alert: json['alert'],
    );
  }
}
