import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/core/utils/validations/textField_validator.dart';
import 'package:technical_test/src/data/sources/firebase_authentication.dart';
import 'package:technical_test/src/presentation/pages/register/sign_up_page.dart';
import 'package:technical_test/src/presentation/widgets/alert_sheets/error_dialog.dart';
import 'package:technical_test/src/presentation/widgets/alert_sheets/snackbar.dart';
import 'package:technical_test/src/presentation/widgets/animations/page_transition_animation.dart';
import 'package:technical_test/src/presentation/widgets/auth_text_field.dart';
import 'package:technical_test/src/presentation/widgets/loading_indicartor.dart';
import 'package:technical_test/src/presentation/widgets/sign_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /// Scaffold key
  final GlobalKey _scaffoldKey = GlobalKey();

  /// controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  /// focus node
  final FocusNode _emailNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();

  /// change field
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /// validate login
  bool _loading = false;

  /// mediaQuery
  final _size = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  /// instance of firebase authentication
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            color: HexColor.fromHex('#EFEEEE'),
            child: Stack(
              children: [
                /// form view
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: _size.size.height,
                      width: _size.size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),

                          /// logo
                          SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.asset('assets/icons/logo.png')),
                          const SizedBox(
                            height: 20,
                          ),

                          /// title
                          SizedBox(
                            width: _size.size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Archive',
                                  color: HexColor.fromHex('#1C2938'),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          /// email field
                          AuthTextField(
                            textFieldType: TextFieldType.email,
                            textEditingController: _emailController,
                            textFocusNode: _emailNode,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'Email address',
                            validationText: "• Invalid email",
                            onFieldSubmitted: () {
                              _fieldFocusChange(context, _emailNode, _pwdNode);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /// password field
                          AuthTextField(
                            textFieldType: TextFieldType.password,
                            textEditingController: _pwdController,
                            textFocusNode: _pwdNode,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            hintText: 'Password',
                            validationText:
                                "• The password must have at least 8 characters.\n• The password must have at least one lowercase letter.\n• The password must have at least one uppercase letter.\n• The password must have numbers.\n• The password must have characters specials.",
                            onFieldSubmitted: () async {
                              _pwdNode.unfocus();
                              _signIn();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Spacer(),

                          /// sign button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SignButton(
                              size: _size,
                              title: 'Sign in',
                              onTap: _signIn,
                            ),
                          ),
                          const Spacer(flex: 2),

                          /// have account text
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "Don't you have an account yet?\n",
                                        style: TextStyle(
                                          color: Colors.grey[900]!
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.2,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'Sign up',
                                          style: TextStyle(
                                            color: HexColor.fromHex('#1C2938'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              /// set vibration
                                              HapticFeedback.lightImpact();

                                              /// open sign up page
                                              Navigator.of(context).push(
                                                  PageTransitionAnimation(
                                                      child: const SignUpPage(),
                                                      direction:
                                                          AxisDirection.left));
                                            })
                                    ]),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),

                /// safe area top color
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: HexColor.fromHex('#EFEEEE'),
                  height: _size.padding.top,
                  width: _size.size.width,
                ),
              ],
            ),
          ),
          if (_loading) const LoadingIndicator()
        ],
      ),
    );
  }

  void _signIn() async {
    if (!isEmail(_emailController.text.trim()) ||
        !isPassword(_pwdController.text.trim())) {
      snackBar(
          scaffoldGlobalKey: _scaffoldKey,
          message: "Please check the fields and try again.",
          color: HexColor.fromHex('#1C2938'),
          labelText: 'close',
          textColor: HexColor.fromHex('#EFEEEE'));
    } else {
      setState(() {
        _loading = !_loading;
      });
      _authentication
          .signInWithEmail(
              email: _emailController.text.trim(),
              password: _pwdController.text.trim(),
              errorCallback: (error) {
                /// show error dialog
                exitDialog(
                    title: 'Authentication error',
                    context: context,
                    message: error.message!);
              })
          .whenComplete(() {
        if (mounted) {
          setState(() {
            _loading = !_loading;
          });
        }
      });
    }
  }
}
