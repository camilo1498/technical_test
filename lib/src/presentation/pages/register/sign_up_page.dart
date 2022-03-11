import 'package:flutter/material.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/core/utils/validations/textField_validator.dart';
import 'package:technical_test/src/data/sources/firebase_authentication.dart';
import 'package:technical_test/src/presentation/widgets/alert_sheets/snackbar.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';
import 'package:technical_test/src/presentation/widgets/auth_text_field.dart';
import 'package:technical_test/src/presentation/widgets/loading_indicartor.dart';
import 'package:technical_test/src/presentation/widgets/sign_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /// form key
  final GlobalKey _scaffoldKey = GlobalKey();
  /// controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdController2 = TextEditingController();
  /// focus node
  final FocusNode _emailNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();
  final FocusNode _pwdNode2 = FocusNode();
  /// change field
  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
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
                              child: Image.asset('assets/icons/logo.png')
                          ),
                          const SizedBox(height: 20,),
                          /// title
                          SizedBox(
                            width: _size.size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                'Register form',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Archive',
                                  color: HexColor.fromHex('#1C2938'),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          /// email field
                          AuthTextField(
                            textFieldType: TextFieldType.email,
                            textEditingController: _emailController,
                            textFocusNode: _emailNode,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'Email address',
                            validationText: "• Invalid email",
                            onFieldSubmitted: (){
                              _fieldFocusChange(context, _emailNode, _pwdNode);
                            },
                          ),
                          const SizedBox(height: 20,),
                          /// password field
                          AuthTextField(
                            textFieldType: TextFieldType.password,
                            textEditingController: _pwdController,
                            textFocusNode: _pwdNode,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            hintText: 'Password',
                            validationText: "• The password must have at least 8 characters.\n• The password must have at least one lowercase letter.\n• The password must have at least one uppercase letter.\n• The password must have numbers.\n• The password must have characters specials.",
                            onFieldSubmitted: (){
                              _fieldFocusChange(context, _pwdNode, _pwdNode2);
                            },
                          ),
                          const SizedBox(height: 20,),
                          /// password field
                          AuthTextField(
                            textFieldType: TextFieldType.password,
                            textEditingController: _pwdController2,
                            textFocusNode: _pwdNode2,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            hintText: 'Confirm password',
                            validationText: "• The password must have at least 8 characters.\n• The password must have at least one lowercase letter.\n• The password must have at least one uppercase letter.\n• The password must have numbers.\n• The password must have characters specials.",
                            onFieldSubmitted: (){
                              _pwdNode.unfocus();
                              _signUp();
                            },
                          ),
                          const SizedBox(height: 25,),
                          const Spacer(),
                          /// sign button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SignButton(
                              size: _size,
                              title: 'Sign up',
                              onTap: _signUp,
                            ),
                          ),
                          const Spacer(flex: 2),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 60),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: AnimatedOnTapButton(
                      onTap: (){
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
                )
              ],
            ),
          ),
          if(_loading)
            const LoadingIndicator()
        ],
      ),
    );
  }

  void _signUp(){
    if(
    !isEmail(_emailController.text.trim()) ||
        !isPassword(_pwdController.text.trim()) || !isPassword(_pwdController2.text.trim())
    ){
      snackBar(
          scaffoldGlobalKey: _scaffoldKey,
          message: "Please check the fields and try again.",
          color: HexColor.fromHex('#1C2938'),
          labelText: 'close',
          textColor: HexColor.fromHex('#EFEEEE')
      );
      /// validate if both password fields are match
    } else if(_pwdController.text.trim() != _pwdController2.text.trim()){
      snackBar(
          scaffoldGlobalKey: _scaffoldKey,
          message: "Password does not match.",
          color: HexColor.fromHex('#1C2938'),
          labelText: 'close',
          textColor: HexColor.fromHex('#EFEEEE')
      );
    } else{
      setState(() {
        _loading = !_loading;
      });
      _authentication.signUpWithEmail(
          email: _emailController.text.trim(),
          password: _pwdController2.text.trim(),
          errorCallback: (error){
            print(error.message);
          }
      ).then((value) {
        if(value != null){
          Navigator.of(context).pop();
        }
      }).whenComplete(() {
        setState(() {
          _loading = !_loading;
        });
      });
    }
  }
}
