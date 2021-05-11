import 'package:flutter/material.dart';

import '../commons.dart';

class PostBody extends StatelessWidget {
  const PostBody({
    Key? key,
    required this.content,
    this.maxLines = 3,
  }) : super(key: key);

  final String content;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Text(
        content,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: kPostTextColor,
          fontWeight: FontWeight.w500,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
