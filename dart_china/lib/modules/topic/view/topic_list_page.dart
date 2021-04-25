import 'package:dart_china/modules/pages.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'widgets/widgets.dart';

class TopicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: kMainGradient,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: buildAppBar(),
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CustomSliverHeader(),
                ),
                SliverFillRemaining(
                  child: Center(
                    child: Text('data'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF435AE4),
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: kMainGradient,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: buildAppBar(),
            body: Column(
              children: [
                WelcomeSection(),
                SizedBox(height: 15),
                Expanded(child: TopicSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 72,
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        splashRadius: 25,
        onPressed: () {},
      ),
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
}

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
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
    // print(percent);

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
            child: buildAppBar(),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        splashRadius: 25,
        onPressed: () {},
      ),
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
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
