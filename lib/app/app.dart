import '../util/import/const.dart';
import '../util/import/di.dart';
import '../util/import/packages.dart';
import '../util/import/provider.dart';
import '../util/import/route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        return MaterialApp.router(
          onGenerateTitle: (BuildContext context) => appConstants.appName,
          title: appConstants.appTitle,
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
          theme: themeProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          locale: localeProvider.currentLocale,
          localizationsDelegates: LocaleConfig.localizationDelegates,
          supportedLocales: LocaleConfig.supportedLocales,
        );
      },
    );
  }
}
