import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({Key? key, required this.galleryPhotos}) : super(key: key);
  final List galleryPhotos;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 0,
      left: 0,
      child: SizedBox(
        height: 55,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: galleryPhotos.length,
          itemBuilder: (_,index){
            return Container(
              margin: const EdgeInsets.only(right: 8),
              height: 56.h,
              width: 56.w,
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.2)
              ),
              child: Image.file(File(galleryPhotos[index]),fit: BoxFit.cover,),
            );
          },
        ),
      ),
    );;
  }
}
