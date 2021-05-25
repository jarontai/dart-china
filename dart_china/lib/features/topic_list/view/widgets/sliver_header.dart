part of 'widgets.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  SliverHeader({this.onMenuPressed});

  final VoidCallback? onMenuPressed;
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
                child: WelcomeBlock(),
              ),
            ),
          ),
          SizedBox(
            height: kToolbarHeight,
            child: buildAppBar(context, percent == 0),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, [bool titleVisiable = false]) {
    return AppBar(
      centerTitle: true,
      backgroundColor: titleVisiable ? Color(0xFF4162D2) : Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        splashRadius: kSplashRadius,
        onPressed: () {
          onMenuPressed?.call();
        },
      ),
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
          splashRadius: kSplashRadius,
          icon: Icon(Icons.add),
          onPressed: () {
            // onMenuPressed?.call();
          },
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
