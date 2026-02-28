import 'package:caramelo_app/app/bootstrap.dart';
import 'package:caramelo_app/provider/register_provider.dart';
import 'package:caramelo_app/ui/components/profile_bottom_sheet.dart';
import 'package:caramelo_app/util/import/packages.dart';
import 'package:caramelo_app/util/import/service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await Bootstrap.init();
    // Ensure localization is loaded
    LocalizationService.load(const Locale('pt', 'BR'));
  });

  testWidgets('ProfileBottomSheet renders correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: RegisterProvider.register(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return TextButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (context) => const ProfileBottomSheet(),
                    );
                  },
                  child: const Text('Open Sheet'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileBottomSheet), findsOneWidget);
    expect(find.byIcon(Icons.brightness_6_rounded), findsOneWidget);
    expect(find.byIcon(Icons.language_rounded), findsOneWidget);
  });
}
