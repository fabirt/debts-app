class Person {
  int id;
  String name;
  double totalValue;

  Person({
    this.id,
    this.name,
    this.totalValue = 0.0,
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
