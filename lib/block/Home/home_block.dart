import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/apiClient/api_client.dart';
import '../../data/models/post.dart';
import 'home_event.dart';
import 'home_state.dart';
 

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late ApiClient apiClient;
  List<Post> _allPosts = [];
  HomeBloc(this.apiClient) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  void _onFetchPosts(FetchPosts event, Emitter<HomeState> emit) async {
    emit(PostLoading());

    try {
      final posts = await apiClient.getData("posts");
     List<Post> list=[] ;
      for (var entry in posts.body) {
        list.add(Post.fromJson(entry));
      }
      _allPosts = list;
      emit(PostLoaded(list));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
  void _onSearchPosts(SearchPosts event, Emitter<HomeState> emit) async {
    if (event.query.isEmpty) {
      // If the search query is empty, show all posts
      emit(PostLoaded(_allPosts));
    } else {
      // Filter the posts based on the query
      final filteredPosts = _allPosts
          .where((post) => post.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(PostLoaded(filteredPosts));
    }
  }
}
