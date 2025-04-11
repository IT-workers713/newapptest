import '../entities/article.dart';
import '../repositories/articles_repository.dart';

class GetArticlesUseCase {
  final ArticlesRepository repository;

  GetArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.fetchArticles();
  }
}
