import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/presentation/widgets/alert_sheets/snackbar.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';

class Case2 extends StatefulWidget {
  const Case2({Key? key}) : super(key: key);

  @override
  _Case2State createState() => _Case2State();
}

class _Case2State extends State<Case2> {
  /// Scaffold key
  final GlobalKey _scaffoldKey = GlobalKey();
  /// mediaQuery
  final _size = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  /// file object
  File? _cameraImage;
  /// take picture
  Future _pickFromCamera() async{
    try{
      final _image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(_image != null){
        setState(() {
          _cameraImage = File(_image.path);
        });
      }
    } on PlatformException catch(e){
      debugPrint('There was an error while taking the picture: ${e.message}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: _size.size.height,
          width: _size.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: _size.size.width,
                  width: _size.size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: HexColor.fromHex('#1C2938')
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: _cameraImage != null ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: PhotoView.customChild(
                          minScale: 1.0,
                          child: Image(
                            image: FileImage(_cameraImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: AnimatedOnTapButton(
                            onTap: (){
                              setState(() {
                                _cameraImage = null;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex('#EFEEEE'),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                  Icons.delete_outline,
                                  color: HexColor.fromHex('#1C2938')
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ) : Center(
                    child: Text(
                      'No photo taken.',
                      style: TextStyle(
                          color: HexColor.fromHex('#1C2938'),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AnimatedOnTapButton(
                onTap: () => _pickFromCamera(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: HexColor.fromHex('#1C2938'),
                            blurRadius: 3,
                            spreadRadius: 0.5,
                            offset: const Offset(0,1)
                        )
                      ]
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Text(
                      'Take a picture',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              if(_cameraImage != null)
                AnimatedOnTapButton(
                  onTap: () async{
                    final _res = await ImageGallerySaver.saveImage(
                        _cameraImage!.readAsBytesSync(),
                        quality: 100,
                        name: DateTime.now().toString()
                    );
                    if(_res != null){
                      snackBar(
                          scaffoldGlobalKey: _scaffoldKey,
                          message: "Photo saved in gallery.",
                          color: HexColor.fromHex('#1C2938'),
                          labelText: 'close',
                          textColor: HexColor.fromHex('#EFEEEE')
                      );
                    } else{
                      snackBar(
                          scaffoldGlobalKey: _scaffoldKey,
                          message: "There was wrong while saving image.",
                          color: HexColor.fromHex('#1C2938'),
                          labelText: 'close',
                          textColor: HexColor.fromHex('#EFEEEE')
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: HexColor.fromHex('#1C2938'),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: const Offset(0,1)
                          )
                        ]
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Text(
                        'Save in gallery',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              const Spacer(flex: 5,)
            ],
          ),
        ),
      ),
    );
  }
}
