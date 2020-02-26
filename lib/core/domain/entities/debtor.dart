class Debtor {
  int id;
  String name;
  double debt;

  Debtor({this.id, this.name, this.debt = 0.0});

  String getInitials() {
    String initials = '';
    final values = name.split(' ');
    for (final v in values) {
      if (initials.length < 2) initials += v[0];
    }
    return initials;
  }
}
