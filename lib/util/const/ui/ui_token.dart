import '../../import/packages.dart';

class UiToken {
  // COLOR TOKENS
  // Primary color tokens
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

  // Primary color tokens
  // Secondary Light Color Scheme
  static const Color secondaryLight50 = Color(0xFFF9FAFB);
  static const Color secondaryLight100 = Color(0xFFF3F4F6);
  static const Color secondaryLight200 = Color(0xFFE5E7EB);
  static const Color secondaryLight300 = Color(0xFFD0D5DD);
  static const Color secondaryLight400 = Color(0xFF9CA3AF);
  static const Color secondaryLight500 = Color(0xFF6B7280);
  static const Color secondaryLight600 = Color(0xFF4B5563);
  static const Color secondaryLight700 = Color(0xFF374151);
  static const Color secondaryLight800 = Color(0xFF1F2937);
  static const Color secondaryLight900 = Color(0xFF111827);
  static const Color secondaryLight950 = Color(0xFF030712);

  // Secondary Dark Color Scheme
  static const Color secondaryDark50 = Color(0xFF030712);
  static const Color secondaryDark100 = Color(0xFF040914);
  static const Color secondaryDark200 = Color(0xFF060A16);
  static const Color secondaryDark300 = Color(0xFF080B18);
  static const Color secondaryDark400 = Color(0xFF0A0C1A);
  static const Color secondaryDark500 = Color(0xFF0C0D1C);
  static const Color secondaryDark600 = Color(0xFF0E0F1E);
  static const Color secondaryDark700 = Color(0xFF101120);
  static const Color secondaryDark800 = Color(0xFF121322);
  static const Color secondaryDark900 = Color(0xFF141524);
  static const Color secondaryDark950 = Color(0xFF161726);

  // Success Color Scheme
  static const Color successLight50 = Color(0xFFF0FDF4);
  static const Color successLight100 = Color(0xFFDCFCE7);
  static const Color successLight200 = Color(0xFFBBF7D0);
  static const Color successLight300 = Color(0xFF86EFAC);
  static const Color successLight400 = Color(0xFF4ADE80);
  static const Color successLight500 = Color(0xFF22C55E);
  static const Color successLight600 = Color(0xFF16A34A);
  static const Color successLight700 = Color(0xFF15803D);
  static const Color successLight800 = Color(0xFF166534);
  static const Color successLight900 = Color(0xFF14532D);
  static const Color successLight950 = Color(0xFF052E16);

  // Error Color Scheme
  static const Color errorLight50 = Color(0xFFFEE2E2);
  static const Color errorLight100 = Color(0xFFFECACA);
  static const Color errorLight200 = Color(0xFFFCA5A5);
  static const Color errorLight300 = Color(0xFFF87171);
  static const Color errorLight400 = Color(0xFFEF4444);
  static const Color errorLight500 = Color(0xFFDC2626);
  static const Color errorLight600 = Color(0xFFB91C1C);
  static const Color errorLight700 = Color(0xFF991B1B);
  static const Color errorLight800 = Color(0xFF7F1D1D);
  static const Color errorLight900 = Color(0xFF6B2121);
  static const Color errorLight950 = Color(0xFF450A0A);

  // Alert Color Scheme
  static const Color alertLight50 = Color(0xFFFEF3C7);
  static const Color alertLight100 = Color(0xFFFEDF89);
  static const Color alertLight200 = Color(0xFFFEC84B);
  static const Color alertLight300 = Color(0xFFFDB022);
  static const Color alertLight400 = Color(0xFFF79009);
  static const Color alertLight500 = Color(0xFFEA580C);
  static const Color alertLight600 = Color(0xFFD9460A);
  static const Color alertLight700 = Color(0xFFB43308);
  static const Color alertLight800 = Color(0xFF922707);
  static const Color alertLight900 = Color(0xFF782206);
  static const Color alertLight950 = Color(0xFF451203);

  // Text Sizes
  static const double textSize8 = 8.0;
  static const double textSize10 = 10.0;
  static const double textSize12 = 12.0;
  static const double textSize14 = 14.0;
  static const double textSize16 = 16.0;
  static const double textSize20 = 20.0;
  static const double textSize24 = 24.0;
  static const double textSize32 = 32.0;
  static const double textSize40 = 40.0;

  // Border Radius
  static const double borderRadiusNone = 0.0;
  static const double borderRadius4 = 4.0;
  static const double borderRadius8 = 8.0;
  static const double borderRadius12 = 12.0;
  static const double borderRadius16 = 16.0;
  static const double borderRadius24 = 24.0;
  static const double borderRadiusFull = 50.0;

  // Spacing
  static const double spacingNone = 0.0;
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;

  // Shadow
  static const double shadowNone = 0.0;
  static const double shadow4 = 4.0;
  static const double shadow8 = 8.0;
  static const double shadow12 = 12.0;
  static const double shadow16 = 16.0;
  static const double shadow20 = 20.0;
  static const double shadow24 = 24.0;
  static const double shadow32 = 32.0;
  static const double shadow40 = 40.0;

  // Elevation
  static const double elevationNone = 0.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation20 = 20.0;
  static const double elevation24 = 24.0;
  static const double elevation32 = 32.0;
  static const double elevation40 = 40.0;

  // Opacity
  static const double opacityNone = 0.0;
  static const double opacity20 = 0.20;
  static const double opacity25 = 0.25;
  static const double opacity40 = 0.40;
  static const double opacity50 = 0.50;
  static const double opacity60 = 0.60;
  static const double opacity75 = 0.75;
  static const double opacity80 = 0.80;
  static const double opacity100 = 1.0;

  // Font Family
  static const String fontFamily = 'Nunito';
}
