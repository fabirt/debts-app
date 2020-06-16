class Person {
  int id;
  String name;
  double total;

  Person({
    this.id,
    this.name,
    this.total = 0.0,
  });

  String getInitials() {
    String initials = '';
    final values = name.split(' ');
    for (final v in values) {
      if (initials.length < 2) initials += v[0];
    }
    return initials;
  }
}
