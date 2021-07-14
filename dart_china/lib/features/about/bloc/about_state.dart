part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();
  
  @override
  List<Object> get props => [];
}

class AboutInitial extends AboutState {}
