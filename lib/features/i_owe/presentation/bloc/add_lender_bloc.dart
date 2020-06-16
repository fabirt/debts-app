import 'package:rxdart/subjects.dart';
import 'package:debts_app/core/utils/utils.dart';

class AddLenderBloc {
  final _nameController = BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream.transform(
        Validators.validateExistingField,
      );

  Function(String) get changeName => _changeName;

  String get name {
    return _nameController.value;
  }

  void _changeName(String name) {
    _nameController.sink.add(name);
  }

  void dispose() {
    _nameController.close();
  }
}
