import 'package:flutter/material.dart';

import '../atom.dart';



// import 'package:widget_preview/widget_preview.dart';
// import 'package:device_frame/device_frame.dart';

// @Preview()
// List<WidgetPreview> preview() {
//   return WidgetPreview(
//       name: 'BannerHost',
//       device: Devices.ios.all.first,
//       hight: 700,
//       child: PulsingButton(
//         onPressed: () {},
//         icon: const Icon(Icons.add),
//       ));
// }

class PulsingButton extends StatefulWidget {
  const PulsingButton(
      {super.key, required this.onPressed, required this.icon, this.baseColor});
  final VoidCallback onPressed;
  final Icon icon;
  final Color? baseColor; // Single base color

  @override
  State<PulsingButton> createState() => _PulsingButtonState();
}

class _PulsingButtonState extends State<PulsingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _btnAnimController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..repeat();
  late final CurvedAnimation _btnAnim =
      CurvedAnimation(curve: Curves.linear, parent: _btnAnimController);

  @override
  void dispose() {
    _btnAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? Theme.of(context).primaryColor;
    Color splashColor = baseColor.withOpacity(0.7); // Derived splash color
    Color hoverColor = baseColor.withOpacity(0.8); // Derived hover color

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        FadeTransition(
          opacity: Tween<double>(begin: .7, end: 0).animate(_btnAnim),
          child: ScaleTransition(
            scale: Tween<double>(begin: .5, end: 1).animate(_btnAnim),
            child: CustomPaint(
              painter: CirclePainter(
                radius: 28,
                color: baseColor,
              ),
              //Add a sizedbox child to the CustomPaint, to give the button more hit area
              child: const SizedBox(
                width: 70,
                height: 70,
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _btnAnimController,
          builder: (BuildContext context, Widget? child) {
            double opacity =
                Tween<double>(begin: .7, end: .9).transform(_btnAnim.value);
            return MaterialButton(
              height: 28,
              splashColor: splashColor, // Use derived splash color
              hoverColor: hoverColor, // Use derived hover color
              color:
                  baseColor.withOpacity(opacity), // Use base color with opacity

              shape: const CircleBorder(),
              onPressed: widget.onPressed,
              child: widget.icon,
            );
          },
        )
      ],
    );
  }
}
