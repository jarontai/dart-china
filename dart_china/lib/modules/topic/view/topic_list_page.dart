import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'widgets/widgets.dart';

class TopicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: kMainGradient,
      ),
      child: SafeArea(
        child: Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  // floating: true,
                  delegate: SliverHeader(),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  // floating: true,
                  delegate: SliverCategorySelector(),
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
}

class SliverCategorySelector extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF1F6FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          CategorySelector(
            names: ['全部', '分享', '问答', '站务'],
            nums: [100, 62, 30, 2],
            onSelect: (index) => print('category select: $index'),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 145;

  @override
  double get minExtent => 145;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
