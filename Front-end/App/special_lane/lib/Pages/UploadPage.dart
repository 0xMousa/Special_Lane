import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';
import 'package:path/path.dart' as path;

import '../Classes/classes.dart';

class UploadPage extends StatefulWidget {
  static final id = 'UploadPageId';

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  File imageFile;
  User user;
  bool isLoading;
  bool isSuccess;

  @override
  void initState() {
    super.initState();
    user = Provider.of<User>(context, listen: false);
    isLoading = false;
    isSuccess = null;
  }

  gallery() {
    pickImage(ImageSource.gallery);
  }

  camera() {
    pickImage(ImageSource.camera);
  }

  void uploadFile(filePath) async {
    Dio dio = Dio();
    String fileName = path.basename(filePath.path);
    print("file base name:$fileName");

    try {
      setState(() {
        isLoading = true;
      });
      FormData formData = new FormData.fromMap({
        'image':
            await MultipartFile.fromFile(filePath.path, filename: fileName),
      });
      dio.options.headers['cookie'] = user.headers['cookie'];
      isLoading = true;
      Response response = await dio.post(
        API.upload,
        data: formData,
      );
      if (response.statusCode == 200) {
        setState(() {
          isSuccess = true;
        });
        user.addPoints();
      }
      print("File upload response: $response");
    } catch (e) {
      print("expectation Caugch: $e");
    }
    setState(() {
      isLoading = false;
      if (isSuccess == null) {
        isSuccess = false;
      }
    });
    if (isSuccess == false) {
      user.subtractPoints();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    if (isLoading) {
      return;
    }
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  clear() {
    setState(() => imageFile = null);
  }

  Future<void> edit() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: UI.imageWidth.toInt(),
      maxHeight: UI.imageHeight.toInt(),
      androidUiSettings: AndroidUiSettings(
        toolbarColor: UI.backgroundColor,
        toolbarWidgetColor: UI.primaryFontColor,
      ),
    );

    setState(() {
      imageFile = cropped ?? imageFile;
    });
  }

  done() async {
    uploadFile(imageFile);
  }

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  nvigate(String id) {
    scaffoldKey.currentState.openEndDrawer();
    if (id != UploadPage.id) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return IdToPage.idToPage(id);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(
        pageId: UploadPage.id,
        nvigate: nvigate,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRow(
                child: GestureDetector(
                  onTap: openDrawer,
                  child: Icon(
                    Icons.menu,
                    size: UI.iconSize[3],
                    color: UI.primaryFontColor,
                  ),
                ),
                index: 0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Take, Pick and\nupload pictures.',
                style: TextStyle(
                  color: UI.primaryFontColor,
                  fontSize: UI.fontSize[1],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              getImage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: UI.backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: camera,
                child: Icon(
                  Icons.camera,
                  size: UI.iconSize[1],
                  color: (isLoading ? UI.darkColor : UI.primaryFontColor),
                ),
              ),
              GestureDetector(
                onTap: gallery,
                child: Icon(
                  Icons.image,
                  size: UI.iconSize[1],
                  color: (isLoading ? UI.darkColor : UI.primaryFontColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getImage() {
    if (imageFile == null) {
      return Container();
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: UI.imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: isSuccess == null
                ? Image.file(imageFile)
                : isSuccess
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.file(imageFile),
                          Icon(
                            Icons.done,
                            size: UI.iconSize[0],
                            color: UI.pureGreen,
                          ),
                        ],
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.file(imageFile),
                          Icon(
                            Icons.close,
                            size: UI.iconSize[0],
                            color: UI.pureRed,
                          ),
                        ],
                      ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: isLoading
                ? Loading()
                : isSuccess == null
                    ? ImageTools(
                        clear: clear,
                        edit: edit,
                        done: done,
                      )
                    : isSuccess
                        ? Text(
                            '+20',
                            style: TextStyle(
                              color: UI.pureGreen,
                              fontSize: UI.fontSize[2],
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '-20',
                            style: TextStyle(
                              color: UI.pureRed,
                              fontSize: UI.fontSize[2],
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
