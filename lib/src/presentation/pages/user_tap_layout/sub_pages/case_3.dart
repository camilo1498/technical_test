import 'package:flutter/material.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/data/model/post_model.dart';
import 'package:technical_test/src/data/sources/fetch_api.dart';
import 'package:technical_test/src/presentation/pages/user_tap_layout/sub_pages/detail_page.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';
import 'package:technical_test/src/presentation/widgets/animations/page_transition_animation.dart';

class Case3 extends StatelessWidget {
  const Case3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Scaffold key
    final GlobalKey _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HexColor.fromHex('#EFEEEE'),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
        child: FutureBuilder<List<PostModel>>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return AnimatedOnTapButton(
                    onTap: () {
                      /// go to detail page
                      Navigator.of(context).push(PageTransitionAnimation(
                          child: DetailPage(
                            postModel: snapshot.data![i],
                          ),
                          direction: AxisDirection.left));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor.fromHex('#1C2938'),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '${i + 1}.',
                                style: TextStyle(
                                  color: HexColor.fromHex('#1C2938'),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![i].title!.toUpperCase(),
                                  style: TextStyle(
                                    color: HexColor.fromHex('#1C2938'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Loading data',
                      style: TextStyle(
                        color: HexColor.fromHex('#1C2938'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
