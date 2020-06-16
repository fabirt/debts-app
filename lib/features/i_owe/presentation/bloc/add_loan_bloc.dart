import 'package:rxdart/rxdart.dart';
import 'package:debts_app/core/utils/utils.dart';

class AddLoanBloc {
  final _valueController = BehaviorSubject<String>();
  final _noteController = BehaviorSubject<String>();
  String _date = DateTime.now().toIso8601String();

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

  Function(String) get changeDate => _changeDate;

  String get value => _valueController.value;

  String get note => _noteController.value;

  String get date => _date;

  void _changeValue(String event) {
    final replaced = event.replaceAll('.', '');
    _valueController.sink.add(replaced);
  }

  void _changeNote(String event) {
    _noteController.sink.add(event);
  }

  void _changeDate(String event) {
    _date = event;
  }

  void dispose() {
    _valueController.close();
    _noteController.close();
  }
}
