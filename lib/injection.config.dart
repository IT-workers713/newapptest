// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/repositories/articles_repository.dart' as _i3;
import 'domain/usecases/get_articles_usecase.dart' as _i4;
import 'injectable_modules.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.ArticlesRepository>(
      () => registerModule.articlesRepository);
  gh.lazySingleton<_i4.GetArticlesUseCase>(
      () => registerModule.getArticlesUseCase);
  return get;
}

class _$RegisterModule extends _i5.RegisterModule {}
