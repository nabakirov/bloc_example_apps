
import 'package:bloc_example_apps/pages/infinite_list/post.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_example_apps/pages/infinite_list/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('infinite scroll')),
      body: BlocProvider(
        builder: (context) => PostBloc(httpClient: http.Client())..dispatch(Fetch()),
        child: InfiniteScroll()
      )
    );
  }
}

class InfiniteScroll extends StatefulWidget {
  @override
  _InfiniteScrollState createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostUninitialized) {
          return Center(
            child: CircularProgressIndicator()
          );
        }
        if (state is PostError) {
          return Center(
            child: Text('failed to fetch posts')
          );
        }
        if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts')
            );
          }
        }
        
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return index >= (state as PostLoaded).posts.length ? ButtomLoader() : PostWidget(post: (state as PostLoaded).posts[index]);
          },
          itemCount: (state as PostLoaded).hasReachedMax ? (state as PostLoaded).posts.length : (state as PostLoaded).posts.length + 1,
          controller: _scrollController,
        );
      }
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
  }
}

class ButtomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(strokeWidth: 1.5,)
        )
      )
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key key, @required this.post}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${post.id}', style: TextStyle(fontSize: 10)),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true

    );
  }
}