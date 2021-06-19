part of 'widgets.dart';

class HomeSliverHeader extends SliverPersistentHeaderDelegate {
  HomeSliverHeader({
    required this.onMenuPressed,
    required this.onSearchPressed,
    this.badge = false,
  });

  final bool badge;
  final VoidCallback onMenuPressed;
  final VoidCallback onSearchPressed;
  final double _expandedHeight = 130;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double welcomeHeight = _expandedHeight - kToolbarHeight;
    final offset = welcomeHeight - shrinkOffset;

    double percent = offset / welcomeHeight;
    if (percent < 0) {
      percent = 0;
    }
    return SizedBox(
      height: _expandedHeight,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: percent,
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: WelcomeBlock(
                  onSearchPressed: onSearchPressed,
                ),
              ),
            ),
          ),
          SizedBox(
            height: kToolbarHeight,
            child: _buildAppBar(context, percent == 0),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, [bool titleVisiable = false]) {
    Widget menuButton = IconButton(
      icon: badge
          ? Badge(
              child: Icon(Icons.menu),
              position: BadgePosition.topEnd(top: 0, end: -2))
          : Icon(Icons.menu),
      splashRadius: kSplashRadius,
      onPressed: () {
        onMenuPressed.call();
      },
    );

    return AppBar(
      centerTitle: true,
      backgroundColor: titleVisiable ? Color(0xFF4162D2) : Colors.transparent,
      elevation: 0,
      leading: menuButton,
      title: titleVisiable
          ? Text(
              'Dart China',
              style: TextStyle(
                color: Colors.grey.shade100,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      actions: [
        IconButton(
          iconSize: 26,
          splashRadius: kSplashRadius,
          icon: Icon(Icons.search_outlined),
          onPressed: onSearchPressed,
        )
      ],
    );
  }

  @override
  double get maxExtent => _expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
