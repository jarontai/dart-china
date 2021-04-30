import 'package:bloc/bloc.dart';
import 'package:discourse_api/discourse_api.dart';
import 'package:meta/meta.dart';

import '../../../repositories/repositories.dart';

export 'package:discourse_api/discourse_api.dart' show Topic;

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  final TopicRepository repository = TopicRepository();

  TopicCubit() : super(TopicInitial());

  void fetchLatest() async {
    var topics = await repository.latestTopics();
    emit(TopicSuccess(topics));
  }
}
