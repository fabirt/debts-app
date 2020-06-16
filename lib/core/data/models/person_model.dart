import 'package:debts_app/core/domain/entities/person.dart';

class PersonModel extends Person {
  PersonModel({
    int id,
    String name,
    double total,
  }) : super(
          id: id,
          name: name,
          total: total,
        );

  factory PersonModel.fromJson(Map map) {
    return PersonModel(
      id: map['id'],
      name: map['name'],
      total: map['total'],
    );
  }

  factory PersonModel.fromEntity(Person person) {
    return PersonModel(
      id: person.id,
      name: person.name,
      total: person.total,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.trim(),
      'total': total,
    };
  }
}
