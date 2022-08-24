import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
//封装带缓存的Image
Widget cacheImage(String url,
    {double? width,
    double? height,
    fit: BoxFit.cover,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    bool clearMemoryCacheWhenDispose = false}) {
  return ExtendedImage.network(
    url,
    shape: shape,
    height: height,
    width: width,
    fit: fit,
    borderRadius: borderRadius,
    //图片从 tree 中移除，清掉内存缓存，以减少内存压力
    clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
  );
}

ImageProvider cachedNetworkImageProvider(String url) {
  if(url.isEmpty){
    url = "https://img0.baidu.com/it/u=2568650289,2027149816&fm=253&fmt=auto&app=138&f=JPEG?w=224&h=152";
  }
  return ExtendedNetworkImageProvider(url);
}
