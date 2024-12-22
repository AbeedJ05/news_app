import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsState {
  final bool isLoading;
  final NewsModel newsModel;

  NewsState({required this.isLoading, required this.newsModel});

  NewsState copyWith({bool? isLoading, NewsModel? newsModel}) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      newsModel: newsModel ?? this.newsModel,
    );
  }
}

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier()
      : super(NewsState(
          isLoading: true,
          newsModel: NewsModel(articles: []),
        )) {
    loadNews();
  }

  Future<void> loadNews() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await NewsService().fetchNews();
      // Ensure the response contains a 'results' field which is a list of news items
      if (response['results'] != null) {
        final List<dynamic> newsResponse = response['results'];
        final newsList = newsResponse.map((item) => Article.fromJson(item)).toList();
        final newsModel = NewsModel(articles: newsList);
        state = state.copyWith(newsModel: newsModel, isLoading: false);
      } else {
        // Handle case where 'results' is not in the response
        throw Exception("No results found in the response.");
      }
    } catch (error) {
      // Handle error gracefully (e.g., show an error message)
      print('Error loading news: $error');
      state = state.copyWith(isLoading: false);
    }
  }

  //Uncomment and modify the following method for search functionality
  Future<void> loadSearchedNews(String title) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await NewsService().fetchNewsBySearching(title);
      if (response['results'] != null) {
        final List<dynamic> newsResponse = response['results'];
        final newsList = newsResponse.map((item) => Article.fromJson(item)).toList();
        final newsModel = NewsModel(articles: newsList);
        state = state.copyWith(newsModel: newsModel, isLoading: false);
      } else {
        throw Exception("No results found for searched news.");
      }
    } catch (error) {
      print('Error loading searched news: $error');
      state = state.copyWith(isLoading: false);
    }
  }
}

final newsProvider =
    StateNotifierProvider<NewsNotifier, NewsState>((ref) => NewsNotifier());
