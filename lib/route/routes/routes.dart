class RouteInfo {
  final String name;
  final String path;

  RouteInfo({required this.name, required this.path});
}

class Routes {
  static List<RouteInfo> routes = [RouteInfo(name: 'Início', path: '/home')];

  static String getPathByName(String name) {
    return routes.firstWhere((element) => element.name == name).path;
  }

  static List<String> get allRoutesNames => routes.map((e) => e.name).toList();

  static String get home =>
      routes.firstWhere((element) => element.name == 'Início').path;
}
