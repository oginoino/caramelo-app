import 'package:caramelo_app/app/app.dart';
import 'package:caramelo_app/app/bootstrap.dart';
import 'package:caramelo_app/provider/register_provider.dart';
import 'package:caramelo_app/ui/components/custom_sliver_app_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await Bootstrap.init();
  });

  testWidgets('App widget should render the Home route', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(providers: RegisterProvider.register(), child: const App()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(CustomSliverAppBar), findsOneWidget);
  });
}
