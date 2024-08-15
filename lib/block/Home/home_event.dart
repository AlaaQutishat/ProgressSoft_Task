import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}



class FetchPosts extends HomeEvent {

  @override
  List<Object> get props => [];
}

class SearchPosts extends HomeEvent {
  final String query;

  const SearchPosts(this.query);

  @override
  List<Object> get props => [query];
}
