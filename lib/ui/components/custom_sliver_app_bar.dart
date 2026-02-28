import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/ui.dart';
import 'profile_avatar.dart';
import 'profile_bottom_sheet.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    this.child,
    this.expandedHeight = 220,
  });

  final String? title;
  final Widget? child;
  final double expandedHeight;

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
      expandedHeight: widget.expandedHeight,
      leading: ProfileAvatar(
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
      ),
      actions: [
        CartActionButton(
          tooltip: 'Carrinho',
          onPressed: () {
            // TODO: navegar para a tela do carrinho
          },
        ),
      ],
    );
  }
}
