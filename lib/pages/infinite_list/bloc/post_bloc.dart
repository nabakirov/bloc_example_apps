import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_example_apps/pages/infinite_list/post.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;
  PostBloc({@required this.httpClient});

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts((currentState as PostLoaded).posts.length, 20);
          yield posts.isEmpty 
            ? (currentState as PostLoaded).copyWith(hasReachedMax: true) 
            : PostLoaded(posts: (currentState as PostLoaded).posts + posts, hasReachedMax: false); 
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) => state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
      'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit'
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body']
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
  @override
  Stream<PostState> transform(Stream<PostEvent> events, Stream<PostState> Function(PostEvent event) next) {
    return super.transform((events as Observable<PostEvent>).debounceTime(
      Duration(milliseconds: 500)
    ), next);
  }
}
