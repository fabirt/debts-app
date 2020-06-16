import 'package:rxdart/rxdart.dart';
import 'package:debts_app/core/utils/utils.dart';

class AddDebtBloc {
  final _valueController = BehaviorSubject<String>();
  final _noteController = BehaviorSubject<String>();

  Stream<String> get valueStream => _valueController.stream.transform(
        Validators.validateExistingField,
      );
  Stream<String> get noteStream => _noteController.stream.transform(
        Validators.validateExistingField,
      );

  Stream<bool> get validStream => CombineLatestStream.combine2(
        valueStream,
        noteStream,
        (e, p) {
          if (e == value && p == note) {
            return true;
          } else {
            return false;
          }
        },
      );

  Function(String) get changeValue => _changeValue;

  Function(String) get changeNote => _changeNote;

  String get value {
    return _valueController.value;
  }

  String get note {
    return _noteController.value;
  }

  void _changeValue(String event) {
    final replaced = event.replaceAll('.', '');
    _valueController.sink.add(replaced);
  }

  void _changeNote(String event) {
    _noteController.sink.add(event);
  }

  void dispose() {
    _valueController.close();
    _noteController.close();
  }
}
