import 'dart:async';

class Validators {
  static final StreamTransformer<String, String> validateExistingField =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value != null && value.isNotEmpty) {
      sink.add(value);
    } else {
      sink.addError('error');
    }
  });
}
