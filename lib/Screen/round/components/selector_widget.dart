import 'package:app/utils/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SelectorWidget extends StatefulWidget {
  final ValueChanged<int> valueChanged;
  final bool? isPars;
  final bool fromhits;
  final List list;
  const SelectorWidget(
      {super.key,
      required this.list,
      required this.fromhits,
      required this.isPars,
      required this.valueChanged});

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade900,
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () => buttonCarouselController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear),
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: AppTheme.primaryColor,
                  )),
            ),
            VerticalDivider(
                width: 20,
                thickness: !widget.fromhits ? 0.3 : 1,
                // indent: 2,
                endIndent: 0,
                color: Colors.white),
            Expanded(
              child: Container(
                // width: 350,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      widget.valueChanged(widget.list[index]);
                    },
                  ),
                  carouselController: buttonCarouselController,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return FittedBox(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            widget.isPars == true
                                ? '  ${widget.list[index]}\nPar'
                                : '${widget.list[index]}',
                            style: const TextStyle(
                                fontSize: 4.0, color: AppTheme.primaryColor),
                          )),
                    );
                  },
                  itemCount: widget.list.length,
                ),
              ),
            ),
            VerticalDivider(
              // width: 20,
              thickness: widget.fromhits ? 0.3 : 1,
              // indent: 10,
              endIndent: 0,
              color: Colors.white,
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () => buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.primaryColor,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
