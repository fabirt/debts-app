import 'package:debts_app/core/domain/entities/debt.dart';

class DebtModel extends Debt {
  DebtModel({
    int id,
    int parentId,
    String date,
    double value,
    String description,
  }) : super(
          id: id,
          parentId: parentId,
          date: date,
          value: value,
          description: description,
        );

  factory DebtModel.fromJson(Map<String, dynamic> json) {
    return DebtModel(
      id: json['id'],
      parentId: json['parent_id'],
      date: json['date'],
      value: json['value'],
      description: json['description'],
    );
  }

  factory DebtModel.fromEntity(Debt debt) {
    return DebtModel(
      id: debt.id,
      parentId: debt.parentId,
      date: debt.date,
      value: debt.value,
      description: debt.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'date': date,
      'value': value,
      'description': description,
    };
  }
}
