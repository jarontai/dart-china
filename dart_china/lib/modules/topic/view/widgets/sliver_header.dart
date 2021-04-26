part of 'widgets.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 130;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarHeight = expandedHeight - shrinkOffset;
    final double welcomeHeight = expandedHeight - kToolbarHeight;
    final offset = welcomeHeight - shrinkOffset;

    double percent = offset / welcomeHeight;
    if (percent < 0) {
      percent = 0;
    }
    return SizedBox(
      height: expandedHeight,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: percent,
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: WelcomeSection(),
              ),
            ),
          ),
          SizedBox(
            height:
                appBarHeight < kToolbarHeight ? kToolbarHeight : appBarHeight,
            child: buildAppBar(percent == 0),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar([bool titleVisiable = false]) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        splashRadius: 25,
        onPressed: () {},
      ),
      title: titleVisiable
          ? Text(
              'Dart China',
              style: TextStyle(
                color: Colors.grey.shade100,
                // fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      actions: [
        IconButton(
          splashRadius: 30,
          icon: CircleAvatar(
            backgroundColor: kTagColr,
            child: Icon(
              Icons.person_outlined,
              color: Colors.grey,
            ),
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
