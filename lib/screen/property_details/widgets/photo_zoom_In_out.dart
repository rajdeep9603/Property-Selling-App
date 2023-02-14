import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';

class PhotoZoomInOut extends StatefulWidget {
  String image;
  List<dynamic>? images = [];

  PhotoZoomInOut({required this.image, required this.images});

  @override
  _PhotoZoomInOutState createState() => _PhotoZoomInOutState();
}

class _PhotoZoomInOutState extends State<PhotoZoomInOut> {
  List<dynamic>? imgs = [];

  @override
  void initState() {
    imgs = widget.images;
    print("------" + imgs.toString());
    print(imgs!.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          // title: InkWell(
          //   onTap: (){
          //     Get.back();
          //   },
          //     child: Icon(Icons.arrow_back,color: ColorRes.white,)),
        ),
        body: /* Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.image.toString()),
          ),
      ),*/
            PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imgs!.length,
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: Get.width,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        child: PhotoView(
                          imageProvider: NetworkImage(
                            widget.images![index].toString(),
                          ),
                        ),
                      ),
                    ],
                  );
                }));
  }
}
