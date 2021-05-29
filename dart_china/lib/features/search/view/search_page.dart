import 'package:flutter/material.dart';

import 'package:dart_china/widgets/widgets.dart';

import '../../../commons.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(
              height: 10,
            ),
            _buildSearchResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      child: Column(
        children: [
          InputWidget(
            prefix: Icon(
              Icons.search,
              color: Colors.grey.shade500,
            ),
            inputAction: TextInputAction.search,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResult() {
    return Expanded(
        child: ListView(
      children: [
        SearchItem(
          avatar: '',
          title: 'title',
          body: 'body',
          time: 'time',
          category: 'category',
        ),
      ],
    ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.white,
      ),
      centerTitle: false,
      title: Text(
        '搜索',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: ColorPalette.backgroundColor,
      elevation: 0,
    );
  }
}

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.avatar,
    required this.title,
    required this.body,
    required this.time,
    required this.category,
  }) : super(key: key);

  final String avatar;
  final String title;
  final String body;
  final String time;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Row(
        children: [
          AvatarButton(
            avatarUrl: avatar,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorPalette.postTextColor,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: ColorPalette.postTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      category,
                      style: TextStyle(
                        color: ColorPalette.postTextColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
