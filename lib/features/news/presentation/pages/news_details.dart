import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/presentation/widgets/news_details/cusom_button.dart';
import 'package:news/features/news/presentation/widgets/news_details/custom_text.dart';
import 'package:news/features/news/presentation/widgets/news_details/news_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsResponse newsResponse;

  const NewsDetailsScreen({super.key, required this.newsResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsImage(newsResponse: newsResponse),
              20.verticalSpace,
              CustomText(
                text: "Title: ${newsResponse.title}",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              20.verticalSpace,
              CustomText(
                text: "Author: ${newsResponse.author}",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              20.verticalSpace,
              CustomText(
                text:"Published At: ${newsResponse.publishedAt}",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              20.verticalSpace,
              CustomText(
                text: "Description: ${newsResponse.description??""}",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
      floatingActionButton: CustomButton(
        onPressed: () => _launchUrl(newsResponse.url),
        buttonText: "Article Website",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}