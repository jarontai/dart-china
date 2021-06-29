import 'package:flutter/material.dart';

import 'package:dart_china/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PostPage extends StatefulWidget {
  PostPage({
    Key? key,
    this.isTopic = true,
    this.postId,
    this.topicId,
  }) : super(key: key);

  final bool isTopic;
  final int? postId;
  final int? topicId;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final form = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    final isTopic = widget.isTopic;
    final isCreate = widget.postId == null;
    final title = isTopic ? (isCreate ? '创建主题' : '编辑主题') : '编辑回复';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              children: [
                ReactiveInputWidget(name: 'title'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
