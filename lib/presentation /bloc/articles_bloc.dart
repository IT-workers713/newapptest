// lib/presentation/bloc/articles_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_articles_usecase.dart';
import 'articles_event.dart';
import 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  ArticlesBloc(this._getArticlesUseCase) : super(ArticlesInitial()) {
    on<FetchArticles>((event, emit) async {
      emit(ArticlesLoading());
      try {
        final articles = await _getArticlesUseCase();
        emit(ArticlesLoaded(articles));
      } catch (e) {
        emit(ArticlesError(e.toString()));
      }
    });
  }
}
