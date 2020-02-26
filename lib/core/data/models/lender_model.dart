class LenderModel {
  int id;
  String name;
  double loan;

  LenderModel({
    this.id,
    this.name,
    this.loan = 0.0,
  });

  factory LenderModel.fromJson(Map<String, dynamic> json) {
    return LenderModel(
      id: json["id"],
      name: json["name"],
      loan: json["loan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "loan": loan,
    };
  }

  String getInitials() {
    String initials = '';
    final values = name.split(' ');
    for (final v in values) {
      if (initials.length < 2) initials += v[0];
    }
    return initials;
  }
}
