import 'package:flutter_test/flutter_test.dart';
import 'package:reservation/utils/methods.dart';
void main() {
  test('calculerTotal multiplie correctement prix et quantité', () {
    expect(calculerTotal(12.5, 2), 25.0);
    expect(calculerTotal(0, 10), 0.0);
    expect(calculerTotal(5, 0), 0.0);
    expect(calculerTotal(3.5, 3), 10.5);
  });
}