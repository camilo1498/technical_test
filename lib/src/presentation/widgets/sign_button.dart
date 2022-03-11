import 'package:flutter/material.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';

class SignButton extends StatelessWidget {
  final MediaQueryData size;
  final Function() onTap;
  final String title;
  const SignButton({
    Key? key,
    required this.size,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapButton(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: 60,
          width: size.size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                    color: HexColor.fromHex('#1C2938').withOpacity(0.5),
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    spreadRadius: 1),
              ]),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
          )),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String iconRoute;
  final Function() onTap;
  final Color backgroundColor;
  const SocialButton(
      {Key? key,
      required this.iconRoute,
      required this.onTap,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapButton(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Center(
          child: Image.asset(
            iconRoute,
          ),
        ),
      ),
    );
  }
}
