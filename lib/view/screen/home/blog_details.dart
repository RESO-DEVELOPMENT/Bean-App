// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../data/models/blog.dart';
import '../../../view_models/menu_view_model.dart';

class BannerDetailScreen extends StatefulWidget {
  final String id;

  // ignore: use_super_parameters
  const BannerDetailScreen({super.key, required this.id});

  @override
  _BannerDetailScreenState createState() => _BannerDetailScreenState();
}

class _BannerDetailScreenState extends State<BannerDetailScreen> {
  BlogModel? blog;
  @override
  void initState() {
    blog = Get.find<MenuViewModel>().getBlogDetailById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (blog == null) {
      return const Center(child: Text("Không có blog để hiển thịÏ"));
    }
    final htmlData = blog?.metaData ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          blog?.title ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Get.textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              blog!.image!.isEmpty
                  ? 'https://i.imgur.com/X0WTML2.jpg'
                  : blog?.image ?? '',
              width: Get.width,
              height: Get.width * 0.5,
              fit: BoxFit.cover,
            ),
            Html(
              data: htmlData,
            ),
          ],
        ),
      ),
    );
  }
}
