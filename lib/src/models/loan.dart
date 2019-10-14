//
class Loan {
  int id;
  int lenderId;
  String date;
  double value;
  String description;

  Loan({
    this.id,
    this.lenderId,
    this.date,
    this.description,
    this.value = 0.0
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      lenderId: json['lender_id'],
      date: json['date'],
      value: json['value'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lender_id': lenderId,
      'date': date,
      'value': value,
      'description': description,
    };
  }

}
