import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const Carousel());

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<String> images = [
    'https://fondosmil.com/fondo/88702.jpg',
    'https://images.squarespace-cdn.com/content/v1/54fc8146e4b02a22841f4df7/1613993182428-R5SIXOIEUZ5FP6XTU9XE/Cover.png',
    'https://p4.wallpaperbetter.com/wallpaper/393/812/986/hatake-kakashi-smiling-mask-naruto-wallpaper-preview.jpg',
    'https://i.pinimg.com/originals/e8/d2/0d/e8d20dd533a9cfe6c2183ee40f25729a.jpg',
    'https://images2.alphacoders.com/100/thumb-1920-1007550.jpg'
  ];

  int _currentPage = 0;
  bool isZoomed = false;

  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();

    controller = TransformationController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Carousel',
      debugShowCheckedModeBanner: false,
      home: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Container(
              key: ValueKey<String>(images[_currentPage]),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(images[_currentPage]),
                      fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 16,
                  sigmaY: 16,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            heightFactor: 0.40,
            child: PageView.builder(
                // physics: isZoomed ? NeverScrollableScrollPhysics() : null,
                itemCount: images.length,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemBuilder: (BuildContext _, int index) {
                  return Container(
                    width: 100,
                    margin: EdgeInsets.all((isZoomed ? 0 : 16)),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter),
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 5))
                        ]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
