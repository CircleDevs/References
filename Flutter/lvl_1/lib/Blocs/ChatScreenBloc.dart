import 'package:rxdart/rxdart.dart';

class ChatScreenBloc {
  final PublishSubject<String> textMessageSubj = PublishSubject<String>();

  /// Handles the text submitted by our ChatScreen
  void handleSubmittedText(String text) {
    print("Handled");
    // Push the text received to any listening observer
    textMessageSubj.sink.add(text);
  }
}