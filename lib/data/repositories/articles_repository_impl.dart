import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/article.dart';
import '../../domain/repositories/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  static const String _apiKey = 'fa05bf4234544cc3abcdf3da027d7e28';
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _boxName = 'articlesBox';

  @override
  Future<List<Article>> fetchArticles() async {
    final box = Hive.box(_boxName);
    await box.delete('cachedArticles');
    final url =
        Uri.parse('$_baseUrl/everything?domains=wsj.com&apiKey=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final articlesJson = data['articles'] as List<dynamic>;
      final articles = articlesJson
          .map<Article>((json) => _articleFromMap(json as Map<String, dynamic>))
          .toList();

      box.put('cachedArticles', articlesJson);
      return articles;
    } else {
      throw Exception('Erreur lors de la récupération des articles');
    }
  }

  Article _articleFromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? '',
      source: (map['source'] != null && map['source']['name'] != null)
          ? map['source']['name'] as String
          : '',
      publishedAt:
          DateTime.tryParse(map['publishedAt'] ?? '') ?? DateTime.now(),
      description: map['description'] as String?,
      url: map['url'] as String?,
    );
  }
}
