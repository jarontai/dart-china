import 'package:bloc/bloc.dart';
import 'package:dart_china/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.authRepository) : super(MessageInitial());

  final UserRepository authRepository;
}
