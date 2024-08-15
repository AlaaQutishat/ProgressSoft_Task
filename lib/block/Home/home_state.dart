import 'package:equatable/equatable.dart';

import '../../data/models/post.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class PostInitial extends HomeState {}

class PostLoading extends HomeState {}

class PostLoaded extends HomeState {
  final List<Post> posts;

  const PostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostError extends HomeState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
