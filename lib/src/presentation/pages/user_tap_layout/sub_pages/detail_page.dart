// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/data/model/post_model.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';

class DetailPage extends StatelessWidget {
  PostModel postModel;
  DetailPage({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EFEEEE'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Detail page',
          style: TextStyle(
            color: HexColor.fromHex('#1C2938'),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: AnimatedOnTapButton(
          onTap: () {
            /// close page
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: HexColor.fromHex('#1C2938'),
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _richText(title: 'Post id: ', subTitle: postModel.id!.toString()),
            const SizedBox(
              height: 10,
            ),
            _richText(
                title: 'User id: ', subTitle: postModel.userId!.toString()),
            const SizedBox(
              height: 10,
            ),
            _richText(
                title: 'Post title: \n', subTitle: postModel.title!.toString()),
            const SizedBox(
              height: 10,
            ),
            _richText(
                title: 'Post content: \n',
                subTitle: postModel.body!.toString()),
          ],
        ),
      ),
    );
  }

  Widget _richText({required title, required subTitle}) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
            color: HexColor.fromHex('#1C2938'),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: subTitle,
          style: TextStyle(
            color: HexColor.fromHex('#1C2938'),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        )
      ]),
    );
  }
}
