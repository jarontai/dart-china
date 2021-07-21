import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common.dart';
import '../../../widgets/widgets.dart';
import '../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final form = FormGroup({
    'search': FormControl<String>(),
  });

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<SearchBloc>().add(SearchInit());

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      var maxExtent = _scrollController.position.maxScrollExtent;
      if (maxExtent > 0 && _scrollController.offset >= (maxExtent * 0.9)) {
        var value = form.control('search').value;
        context
            .read<SearchBloc>()
            .add(SearchFetch(search: value, refresh: false));
      }
    });
  }

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
            _buildSearchBar(context),
            SizedBox(
              height: 10,
            ),
            _buildSearchResult(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            ReactiveInputWidget(
              name: 'search',
              hint: '请输入关键字',
              prefix: Icon(
                Icons.search,
                color: Colors.grey.shade500,
              ),
              inputAction: TextInputAction.search,
              onEditComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
                var value = form.control('search').value;
                context
                    .read<SearchBloc>()
                    .add(SearchFetch(search: value, refresh: true));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return ListLoader();
        }
        if (state.status.isSuccess) {
          final dataCount = state.data.length;
          var itemCount = dataCount;
          if (state.hasMore) {
            itemCount++;
          }

          return Expanded(
              child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= dataCount) {
                return ListLoader();
              }

              var topic = state.data[index].topic;
              var post = state.data[index].post;
              var slug = state.slugs[index];
              var time = DateTime.parse(post.createdAt);

              return SearchItem(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.topic, arguments: topic.id);
                },
                avatar: post.avatar ?? '',
                title: topic.title,
                body: post.blurb,
                time: '${time.year}-${time.month}-${time.day}',
                slug: slug,
              );
            },
            itemCount: itemCount,
          ));
        }
        return Container();
      },
    );
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
    required this.slug,
    required this.onTap,
  }) : super(key: key);

  final String avatar;
  final String title;
  final String body;
  final String time;
  final String slug;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Row(
        children: [
          AvatarButton(
            avatarUrl: avatar,
          ),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
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
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                            // color: ColorPalette.postTextColor,
                            ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: CategoryColorMap[slug],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        kCategoryNameMap[slug] ?? '其他',
                        style: TextStyle(
                          color: ColorPalette.postTextColor,
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
