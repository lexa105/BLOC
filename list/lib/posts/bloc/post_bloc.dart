import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E> (Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}



class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration);
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(PostEvent event, Emitter<PostState> emit) async{
  if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          status: PostStatus.success,
        ));
      }
      final posts = await _fetchPosts 
    }

}


Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
  final response = await httpClient.get(
    Uri.https(
      'jsonplaceholder.typicode.com',
      '/posts',
      <String, String> {'_start': '$startIndex', '_limit' : $postLimit}
  ));
} 

}




