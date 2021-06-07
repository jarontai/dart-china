import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common.dart';
import '../../../widgets/widgets.dart';
import '../cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final form = FormGroup({
    'search': FormControl<String>(),
  });

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
            InputWidget(
              name: 'search',
              hint: '请输入关键字',
              prefix: Icon(
                Icons.search,
                color: Colors.grey.shade500,
              ),
              inputAction: TextInputAction.done,
              onEditComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
                var value = form.control('search').value;
                context.read<SearchCubit>().search(value, refresh: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        var theState = state;
        if (theState is SearchInitial) {
          return Container();
        }
        if (theState is SearchLoading) {
          return Expanded(
              child: ListView(
            children: [
              SearchItem(
                onTap: () {},
                avatar: '',
                title: 'Loading',
                body: 'body',
                time: 'time',
                category: 'category',
              ),
            ],
          ));
        }
        if (theState is SearchSuccess) {
          return Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              var topic = theState.data[index].topic;
              var post = theState.data[index].post;
              return SearchItem(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.topic, arguments: topic.id);
                },
                avatar: '',
                title: topic.title,
                body: post.blurb,
                time: 'time',
                category: 'category',
              );
            },
            itemCount: theState.data.length,
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
    required this.category,
    required this.onTap,
  }) : super(key: key);

  final String avatar;
  final String title;
  final String body;
  final String time;
  final String category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
