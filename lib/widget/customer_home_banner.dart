import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/usecase/get_banner_use_case.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'blossom_image_ratio.dart';

class CustomerHomeBanner extends StatefulWidget {
  @override
  _CustomerHomeBannerState createState() => _CustomerHomeBannerState();
}

class _CustomerHomeBannerState extends State<CustomerHomeBanner> {
  List<Widget> bannerList;
  GetBannerUseCase _getBannerUseCase = Injector.appInstance.get();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    getBannerFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return bannerList == null
        ? BlossomProgressIndicator()
        : Container(
          child: Stack(children: [
              CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 1.2 / 1,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: bannerList,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerList.map((widget) {
                    int index = bannerList.indexOf(widget);
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? BlossomTheme.gray : BlossomTheme.lightGray,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
        );
  }

  Future<void> getBannerFromFirestore() async {
    final result = await _getBannerUseCase.execute(null);
    result.whenWithResult((data) {
      final list = data.map((e) => _createReviewItem(context, e)).toList();
      setState(() {
        bannerList = list;
      });
    }, (map) {});
  }

  Widget _createReviewItem(BuildContext context, Map<String, String> map) {
    return BlossomImageRatio(
      fileStorePath: map["imageURL"],
    );
  }
}
