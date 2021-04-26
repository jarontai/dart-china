import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'widgets/widgets.dart';

class TopicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4162D2),
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F6FA),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFDFDFD),
                              blurRadius: 0,
                              spreadRadius: 0,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: TopicCard(),
                      );
                    },
                    childCount: 10,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
