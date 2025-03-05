import 'package:flutter/widgets.dart';

// import 'package:widget_preview/widget_preview.dart';
// import 'package:device_frame/device_frame.dart';

// @Preview()
// List<WidgetPreview> preview() {
//   return WidgetPreview(
//       name: 'BannerHost',
//       device: Devices.ios.all.first,
//       hight: 700,
//       child: CirclePainter(
//         color: Color(0xffFF0000),
//         radius: 100,
//       ));
// }

class CirclePainter extends CustomPainter {
  final Paint _paint;
  final Color color;
  final double radius;

  CirclePainter({required this.color, required this.radius})
      : _paint = Paint()
          ..color = color
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, _paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
