import '../../import/packages.dart';

class UiToken {
  // Primary Light Color Scheme
  static const Color primaryLight50 = Color(0xFFF0FDF4);
  static const Color primaryLight100 = Color(0xFFDCFCE7);
  static const Color primaryLight200 = Color(0xFFBBF7D0);
  static const Color primaryLight300 = Color(0xFF86EFAC);
  static const Color primaryLight400 = Color(0xFF4ADE80);
  static const Color primaryLight500 = Color(0xFF22C55E);
  static const Color primaryLight600 = Color(0xFF16A34A);
  static const Color primaryLight700 = Color(0xFF15803D);
  static const Color primaryLight800 = Color(0xFF166534);
  static const Color primaryLight900 = Color(0xFF14532D);
  static const Color primaryLight950 = Color(0xFF052E16);

  // Primary Dark Color Scheme
  static const Color primaryDark50 = Color(0xFF052E16);
  static const Color primaryDark100 = Color(0xFF042914);
  static const Color primaryDark200 = Color(0xFF032412);
  static const Color primaryDark300 = Color(0xFF022010);
  static const Color primaryDark400 = Color(0xFF021B0F);
  static const Color primaryDark500 = Color(0xFF01160D);
  static const Color primaryDark600 = Color(0xFF01120B);
  static const Color primaryDark700 = Color(0xFF010D09);
  static const Color primaryDark800 = Color(0xFF010907);
  static const Color primaryDark900 = Color(0xFF000405);
  static const Color primaryDark950 = Color(0xFF000203);

  static const Color primaryLightColor = primaryLight500;
  static const MaterialColor primaryLightColorSwatch =
      MaterialColor(0xFF00E78E, <int, Color>{
        50: primaryLight50,
        100: primaryLight100,
        200: primaryLight200,
        300: primaryLight300,
        400: primaryLight400,
        500: primaryLight500,
        600: primaryLight600,
        700: primaryLight700,
        800: primaryLight800,
        900: primaryLight900,
        950: primaryLight950,
      });

  static const Color primaryDarkColor = primaryDark500;

  static const MaterialColor primaryDarkColorSwatch =
      MaterialColor(0xFF009667, <int, Color>{
        50: primaryDark50,
        100: primaryDark100,
        200: primaryDark200,
        300: primaryDark300,
        400: primaryDark400,
        500: primaryDark500,
        600: primaryDark600,
        700: primaryDark700,
        800: primaryDark800,
        900: primaryDark900,
        950: primaryDark950,
      });
}
