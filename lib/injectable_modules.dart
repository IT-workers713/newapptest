import 'package:injectable/injectable.dart';

import 'data/repositories/articles_repository_impl.dart';
import 'domain/repositories/articles_repository.dart';
import 'domain/usecases/get_articles_usecase.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  ArticlesRepository get articlesRepository => ArticlesRepositoryImpl();

  @lazySingleton
  GetArticlesUseCase get getArticlesUseCase =>
      GetArticlesUseCase(articlesRepository);
}
