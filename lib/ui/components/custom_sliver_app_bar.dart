import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/ui.dart';
import 'profile_bottom_sheet.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({super.key, this.title, this.child});

  final String? title;
  final Widget? child;

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: scaffoldColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: LocationSelectorDropdown(initialSelection: widget.title),
      floating: true,
      snap: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: UiToken.spacing16),
            child: widget.child,
          ),
        ),
      ),
      expandedHeight: 220,
      leading: IconButton(
        tooltip: 'Profile',
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (sheetContext) {
              return const ProfileBottomSheet();
            },
          );
        },
        icon: CircleAvatar(
          radius: UiToken.shadow16,
          backgroundColor: isLightTheme
              ? UiToken.secondaryDark500
              : UiToken.secondaryLight400,
          child: Icon(
            Icons.person_rounded,
            size: UiToken.textSize24,
            color: isLightTheme
                ? UiToken.secondaryLight400
                : UiToken.secondaryDark500,
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Cart',
          onPressed: () {},
          icon: CircleAvatar(
            radius: UiToken.shadow16,
            backgroundColor: isLightTheme
                ? UiToken.secondaryDark500
                : UiToken.secondaryLight400,
            child: Icon(
              Icons.shopping_bag_rounded,
              size: UiToken.textSize24,
              color: isLightTheme
                  ? UiToken.secondaryLight400
                  : UiToken.secondaryDark500,
            ),
          ),
        ),
      ],
    );
  }
}
