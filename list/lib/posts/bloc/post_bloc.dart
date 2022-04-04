import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(_onPostFetched);
  }

  final http.Client httpClient;
}

Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
  
  if (state.hasReachedMax) return;
  try {
    if (state.status == PostStatus.initial) {
      final posts = await _fetchPost();
      return emit(state.copyWith)
    }
  }
}
