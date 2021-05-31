import 'package:flutter/material.dart';
import 'dart:math' as math;

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(overlapsContent);
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class HeaderSliver extends StatefulWidget {
  final Widget? child;
  final double? height;
  HeaderSliver({Key? key, @required this.child, this.height = 100})
      : super(key: key);

  @override
  _HeaderSliverState createState() => _HeaderSliverState();
}

class _HeaderSliverState extends State<HeaderSliver> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: widget.height!,
        maxHeight: widget.height!,
        child: widget.child!,
      ),
    );
  }
}
