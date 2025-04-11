import 'package:get_it/get_it.dart';

import 'data/repositories/articles_repository_impl.dart';
import 'domain/repositories/articles_repository.dart';
import 'domain/usecases/get_articles_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ArticlesRepository>(() => ArticlesRepositoryImpl());

  sl.registerLazySingleton<GetArticlesUseCase>(
    () => GetArticlesUseCase(sl()),
  );
}
