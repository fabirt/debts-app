class Person {
  final int id;
  final String name;
  final double total;

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

  Person copyWith({
    int id,
    String name,
    double total,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      total: total ?? this.total,
    );
  }
}
