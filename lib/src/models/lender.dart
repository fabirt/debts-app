//
class Lender {
  int id;
  String name;
  double loan;

  Lender({this.id, this.name, this.loan = 0.0});

  factory Lender.fromJson(Map<String, dynamic> json) {
    return Lender(
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
    values.forEach((v) {
      if (initials.length < 2) initials += v[0];
    });
    return initials;
  }
}
