import '../util/import/packages.dart';

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(BuildContext context, GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    this.useFade = true,
    this.useCustomSliver = true,
    this.titleBuilder,
    this.titleWidgetBuilder,
    this.leadingBuilder,
    this.actionsBuilder,
    this.padding,
    this.hasScrollBody = false,
  }) : super(
         path: path,
         routes: routes,
         pageBuilder: (context, state) {
           Widget pageContent;
           pageContent = Scaffold(
             body: builder(context, state),
             resizeToAvoidBottomInset: true,
           );
           if (useFade) {
             return CustomTransitionPage(
               key: state.pageKey,
               child: pageContent,
               transitionsBuilder:
                   (context, animation, secondaryAnimation, child) =>
                       FadeTransition(opacity: animation, child: child),
             );
           }
           return MaterialPage(child: pageContent);
         },
       );
  final bool useFade;
  final bool useCustomSliver;
  final String Function(BuildContext context)? titleBuilder;
  final Widget Function(BuildContext context)? titleWidgetBuilder;
  final Widget Function(BuildContext context)? leadingBuilder;
  final List<Widget> Function(BuildContext context)? actionsBuilder;
  final EdgeInsetsGeometry? padding;
  final bool hasScrollBody;
}
