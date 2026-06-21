import 'package:flutter_test/flutter_test.dart';
import 'package:sebolinhas/main.dart';

void main() {
  testWidgets('SeboLinhas app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SeboLinhasApp());
    // A tela de splash é exibida primeiro
    expect(find.text('SeboLinhas'), findsAny);
  });
}
