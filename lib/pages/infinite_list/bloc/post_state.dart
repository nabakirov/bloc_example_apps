import 'package:bloc_example_apps/pages/infinite_list/post.dart' as models;
import 'package:equatable/equatable.dart';


abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostUninitialized extends PostState {
  @override
  String toString() => 'PostUninitialized';
}


class PostError extends PostState {
  @override
  String toString() => 'PostError';
}

class PostLoaded extends PostState {
  final List<models.Post> posts;
  final bool hasReachedMax;

  PostLoaded({
    this.posts,
    this.hasReachedMax
  }) : super([posts, hasReachedMax]);

  PostLoaded copyWith({
    List<models.Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  
  @override
  String toString() => 'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}