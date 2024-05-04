import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/service/remote/service_locator.dart';
import 'package:news/core/widget_life_cycle_listener.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/presentation/controller/news/news_cubit.dart';
import 'package:news/features/news/presentation/pages/news_details.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Category {
  int id;
  String name;
  Category({required this.id, required this.name});
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedCategoryId;

  final newsCubit = ServiceLocator.instance<NewsCubit>();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  List<Category> categoriesList = [
    Category(id: 1, name: "All"),
    Category(id: 2, name: "business"),
    Category(id: 3, name: "entertainment"),
    Category(id: 4, name: "general"),
    Category(id: 5, name: "health"),
    Category(id: 6, name: "science"),
    Category(id: 7, name: "sports"),
    Category(id: 8, name: "technology")
  ];
  void _onRefresh() async{
    // monitor network fetch
    context.read<NewsCubit>().getCategories(NewsRequest( page: 1));
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getCategories(NewsRequest( page: 1));
    // Initialize with no category selected
    selectedCategoryId = 0;
  }

  @override
  void dispose() {
    context.read<NewsCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsLoaded) {
                if (selectedCategoryId == 0) {
                  selectedCategoryId = categoriesList.first.id;
                }
                // Update products when a category is selected
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoriesList
                        .map(
                          (category) => CategoryItem(
                            categoryitem: category,
                            isSelected: selectedCategoryId == category.id,
                            onTap: () {
                              setState(() {
                                selectedCategoryId = category.id;
                              });
                              context.read<NewsCubit>().getCategories(NewsRequest(page: 1,category: category.name));
                            },
                          ),
                        )
                        .toList(),
                  ),
                );
              } else if (state is NewsError) {
                return Center(
                  child: Text(state.errorMessage.msg),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
          BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsLoaded) {
                final news = state.newsResponse;
                return Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        final newsData = news[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ProductItem(newsDetails: newsData),
                        );
                      },
                    ),
                  ),
                );
              } else if (state is NewsError) {
                return Center(
                  child: Text(state.errorMessage.msg),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category categoryitem;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.categoryitem,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.green.shade300 : Colors.grey.shade300,
          ),
          height: 45,
          width: 120,
          child: Center(
            child: Text(categoryitem.name),
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final NewsResponse newsDetails;
  const ProductItem({super.key, required this.newsDetails});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailsScreen(
                      newsResponse: newsDetails,
                    )));
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Left side - Image
            SizedBox(
              width: 100,
              height: 100,
              child: Hero(
                tag: newsDetails.title,
                child: Image.network(
                  newsDetails.urlToImage,
                ),
              ),
            ),
            // Right side - Title, Address, Date
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      maxLines: 1,
                      newsDetails.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      newsDetails.author,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    8.verticalSpace,
                    Text(
                      newsDetails.source.name,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
