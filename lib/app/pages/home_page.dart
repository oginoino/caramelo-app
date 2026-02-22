import '../../util/import/packages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Theme.of(context).platform.name),
      ),
      body: Center(
        child: Text(
          'Caramelo',
          style: context.text.headlineMedium,
        ),
      ),
    );
  }
}
