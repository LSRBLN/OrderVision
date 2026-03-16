import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orderman_flutter/app.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/features/auth/presentation/auth_screen.dart';

void main() {
  testWidgets('Auth screen renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: OrdermanApp(branding: BrandingConfig.current),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(OrdermanApp), findsOneWidget);
    expect(find.byType(AuthScreen), findsOneWidget);
  });
}
