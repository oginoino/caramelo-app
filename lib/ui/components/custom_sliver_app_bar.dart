import '../../util/import/packages.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(title: title != null ? Text(title!) : null);
  }
}
