class LoanModel {
  int id;
  int lenderId;
  String date;
  double value;
  String description;

  LoanModel({
    this.id,
    this.lenderId,
    this.date,
    this.description,
    this.value = 0.0,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
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
