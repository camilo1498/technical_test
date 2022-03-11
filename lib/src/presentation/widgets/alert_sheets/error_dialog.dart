import 'package:flutter/material.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';

Future<bool> exitDialog(
    {required context, required String message, required String title}) async {
  return (await showDialog(
        context: context,
        barrierColor: Colors.black38,
        barrierDismissible: true,
        builder: (c) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetAnimationDuration: const Duration(milliseconds: 300),
          insetAnimationCurve: Curves.ease,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 5, right: 20, left: 20),
              alignment: Alignment.center,
              height: 230,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: HexColor.fromHex('#1C2938'),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white10,
                        offset: Offset(0, 1),
                        blurRadius: 4),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /// title
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: HexColor.fromHex('#EFEEEE'),
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                        letterSpacing: 0.1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  /// close
                  AnimatedOnTapButton(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )) ??
      false;
}
