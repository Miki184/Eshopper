import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget pageTitle;
  final Widget? fIcon;
  final double? fIconSize;
  final Function? fIconFunction;
  final Widget? sIcon;
  final Function? sIconFunction;
  final bool isCenter;
  final double? horizontalMargin;

  CustomAppBar({
    required this.pageTitle,
    this.fIcon,
    this.fIconSize,
    this.fIconFunction,
    this.sIcon,
    this.sIconFunction,
    required this.isCenter,
    this.horizontalMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return isCenter
        ? SafeArea(
      child: Container(
        height: (mediaquery.size.height - mediaquery.padding.top) * 0.088,
        margin: EdgeInsets.symmetric(horizontal: mediaquery.size.width * horizontalMargin!),
        padding: EdgeInsets.only(
          top: (mediaquery.size.height - mediaquery.padding.top) * 0.035,
          bottom: (mediaquery.size.height - mediaquery.padding.top) * 0.012,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => fIconFunction!(),
              child: fIcon,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: mediaquery.size.width * 0.65,
              ),
              child: FittedBox(
                child: pageTitle,
              ),
            ),
            GestureDetector(
              onTap: () => sIconFunction!(),
              child: sIcon,
            ),
          ],
        ),
      ),
    )
        : SafeArea(
      child: Container(
        height: (mediaquery.size.height - mediaquery.padding.top) * 0.078,
        margin: EdgeInsets.symmetric(horizontal: mediaquery.size.width * horizontalMargin!),
        padding: EdgeInsets.only(
          top: (mediaquery.size.height - mediaquery.padding.top) * 0.018,
          bottom: (mediaquery.size.height - mediaquery.padding.top) * 0.012,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                if (fIcon != null)
                  GestureDetector(
                    onTap: () => fIconFunction!(),
                    child: fIcon,
                  ),
                if (fIcon != null) const SizedBox(width: 5),
                pageTitle,
              ],
            ),
            if (sIcon != null)
              GestureDetector(
                onTap: () => sIconFunction!(),
                child: sIcon,
              ),
          ],
        ),
      ),
    );
  }
}