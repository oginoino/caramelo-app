import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/service.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UiToken.spacing16),
      child: TextField(
        decoration: InputDecoration(
          hintText: LocalizationService.strings.search,
          suffixIcon: Icon(Icons.search_rounded),
        ),
      ),
    );
  }
}
