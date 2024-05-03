import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/service/remote/service_locator.dart';
import 'package:news/core/widget_life_cycle_listener.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/presentation/controller/news_cubit.dart';
import 'package:news/features/news/presentation/pages/news_details.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  late int selectedCategoryId;
  final newsCubit = ServiceLocator.instance<NewsCubit>();
  @override
  Widget build(BuildContext context) {

    return WidgetLifecycleListener(
      onInit: () {
        context.read<NewsCubit>().getCategories();
        // Initialize with no category selected
        selectedCategoryId = 0;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // BlocBuilder<NewsCubit, NewsState>(
            //   builder: (context, state) {
            //     if (state is NewsLoading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state is NewsLoaded) {
            //       // Update products when a category is selected
            //       return SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: state.newsResponse
            //               .map(
            //                 (category) => CategoryItem(
            //                   newsResponse: category,
            //                   isSelected: true,
            //                   onTap: () {},
            //                 ),
            //               )
            //               .toList(),
            //         ),
            //       );
            //     } else if (state is NewsError) {
            //       return Center(
            //         child: Text(state.errorMessage.msg),
            //       );
            //     } else {
            //       return const Center(
            //         child: Text('Something went wrong'),
            //       );
            //     }
            //   },
            // ),
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NewsLoaded) {
                  final news = state.newsResponse;
                  return Expanded(
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
      ),
    );
  }
}

// class CategoryItem extends StatelessWidget {
//   final NewsResponse newsResponse;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const CategoryItem({
//     super.key,
//     required this.newsResponse,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: isSelected ? Colors.green.shade300 : Colors.grey.shade300,
//           ),
//           height: 45,
//           width: 80,
//           child: Center(
//             child: Text(newsResponse.title),
//           ),
//         ),
//       ),
//     );
//   }
// }
class ProductItem extends StatelessWidget {
  final NewsResponse newsDetails;
  const ProductItem({super.key, required this.newsDetails});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsScreen(newsResponse: newsDetails,)));
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
                  newsDetails.author!,
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