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
