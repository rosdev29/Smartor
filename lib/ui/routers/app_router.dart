import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/ui/screens/barcode/core.dart';
import 'package:calc_pro/ui/screens/camera/core.dart';
import 'package:calc_pro/ui/screens/history/core.dart';
import 'package:calc_pro/ui/screens/home/core.dart';
import 'package:calc_pro/ui/screens/language/core.dart';
import 'package:calc_pro/ui/screens/qr_code/core.dart';
import 'package:calc_pro/ui/screens/qr_gen/core.dart';
import 'package:calc_pro/ui/screens/splash/core.dart';
import 'package:calc_pro/ui/screens/subscription/core.dart';
import 'package:calc_pro/ui/screens/scanner/core.dart';
import 'package:calc_pro/ui/screens/theme/core.dart';
import 'package:calc_pro/ui/screens/translate/core.dart';
import 'package:calc_pro/ui/screens/view_docx/core.dart';
import 'package:calc_pro/ui/screens/view_pdf/core.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const splashScreen = '/splashScreen';
  static const homeScreen = '/homeScreen';
  static const historyScreen = '/historyScreen';
  static const subscriptionScreen = '/subscriptionScreen';
  static const languageScreen = '/languageScreen';
  static const themeScreen = '/themeScreen';
  static const cameraScreen = '/cameraScreen';
  static const scannerScreen = '/scannerScreen';
  static const translateScreen = '/translateScreen';
  static const qrCodeScreen = '/qrCodeScreen';
  static const viewPdfScreen = '/viewPdfScreen';
  static const qrGenScreen = '/qrGenScreen';
  static const barcodeScreen = '/barcodeScreen';
  static const viewDocxScreen = '/viewDocxScreen';

  static Map<String, Widget Function(BuildContext)> get routes => {
        splashScreen: (_) => const SplashScreen(),
        homeScreen: (_) => const HomeScreen(),
        historyScreen: (_) => const HistoryScreen(),
        subscriptionScreen: (_) => const SubscriptionScreen(),
        languageScreen: (_) => const LanguageScreen(),
        themeScreen: (_) => const ThemeScreen(),
        cameraScreen: (_) => const CameraScreen(),
        scannerScreen: (_) => const ScannerScreen(),
        translateScreen: (_) => const TranslateScreen(),
        qrCodeScreen: (_) => const QrCodeScreen(),
        viewPdfScreen: (_) => const ViewPdfScreen(),
        qrGenScreen: (_) => const QrGenScreen(),
        barcodeScreen: (_) => const BarcodeScreen(),
        viewDocxScreen: (_) => const ViewDocxScreen(),
      };

  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static void pop<T extends Object?>([T? result]) =>
      Navigator.pop(context, result);

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      Navigator.of(context).pushReplacementNamed(routeName,
          result: result, arguments: arguments);

  static Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      Navigator.pushNamed(context, routeName, arguments: arguments);

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String routeName,
          {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
          arguments: arguments);

  static showMessageError(String message) {
    CherryToast.error(
            description: Text(message,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: Colors.black)),
            title: Text(S.current.error,
                style: context.textTheme.titleSmall
                    ?.copyWith(color: Colors.black)),
            animationType: AnimationType.fromRight,
            animationDuration: Duration(milliseconds: 600),
            autoDismiss: true)
        .show(context);
  }

  static showMessageSuccess(String message) {
    CherryToast.success(
            description: Text(message,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: Colors.black)),
            title: Text(S.current.success,
                style: context.textTheme.titleSmall
                    ?.copyWith(color: Colors.black)),
            animationType: AnimationType.fromRight,
            animationDuration: Duration(milliseconds: 600),
            autoDismiss: true)
        .show(context);
  }

  static popUntil({required String routeName}) =>
      Navigator.of(context).popUntil(ModalRoute.withName(routeName));
}
