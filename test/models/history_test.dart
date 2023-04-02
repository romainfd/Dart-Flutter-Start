import 'package:test/test.dart';
import 'package:namer_app/models/history.dart';

void main() {
  group('Testing History', () {
    test('A new pair should be added', () {
      var history = History();
      var initialLength = history.items.length;
      history.getNext();
      expect(history.items.length - initialLength, 1);
    });

    test('Current should be changed', () {
      var history = History();
      var initialCurrent = history.current;
      history.getNext();
      expect(history.current, isNot(initialCurrent));
    });
  });
}
