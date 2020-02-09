//
class Debtor {
  int id;
  String name;
  double debt;

  Debtor({this.id, this.name, this.debt = 0.0});

  factory Debtor.fromJson(Map<String, dynamic> json) {
    return Debtor(
      id: json["id"],
      name: json["name"],
      debt: json["debt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "debt": debt,
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
