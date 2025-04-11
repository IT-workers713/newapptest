import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../domain/entities/article.dart';
import '../../domain/usecases/get_articles_usecase.dart';
import '../../injection.dart';
import '../bloc/articles_bloc.dart';
import '../bloc/articles_event.dart';
import '../bloc/articles_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy', 'fr_FR');

    return BlocProvider(
      create: (_) =>
          ArticlesBloc(getIt<GetArticlesUseCase>())..add(FetchArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.newspaper_rounded,
                              size: 28.sp, color: Colors.black87),
                          SizedBox(width: 8.w),
                          Text('News Feed',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      Icon(Icons.more_vert_rounded,
                          color: Colors.grey.shade600),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D5FEF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      icon: const Icon(LucideIcons.refreshCcw, size: 20),
                      onPressed: () {
                        context.read<ArticlesBloc>().add(FetchArticles());
                      },
                      label: Text('Recharger les articles',
                          style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: BlocBuilder<ArticlesBloc, ArticlesState>(
                      builder: (context, state) {
                        if (state is ArticlesLoading ||
                            state is ArticlesInitial) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is ArticlesLoaded) {
                          final articles = state.articles;
                          if (articles.isEmpty) {
                            return const Center(
                                child: Text('Aucun article trouv\u00e9.'));
                          }
                          return ListView.separated(
                            itemCount: articles.length,
                            separatorBuilder: (_, __) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final Article article = articles[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(article.source,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(
                                            dateFormat
                                                .format(article.publishedAt),
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.grey.shade500,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (state is ArticlesError) {
                          return Center(
                              child: Text('Erreur : ${state.message}'));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
