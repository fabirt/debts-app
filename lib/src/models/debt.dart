//
class Debt {
  int id;
  String date;
  double value;
  String description;

  Debt({
    this.id,
    this.date,
    this.description,
    this.value = 0.0
  });

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      id: json['id'],
      date: json['date'],
      value: json['value'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'value': value,
      'description': description,
    };
  }

}
