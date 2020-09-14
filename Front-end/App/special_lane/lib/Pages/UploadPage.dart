import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';

class UploadPage extends StatefulWidget {
  static final id = 'UploadPageId';

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  File imageFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage(ImageSource source) async {
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
    );

    setState(() {
      imageFile = cropped ?? imageFile;
    });
  }

  done() {
    setState(() => imageFile = null);
  }

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  nvigate(String id) {
    scaffoldKey.currentState.openEndDrawer();
    if (id == HomePage.id) {
      Navigator.pop(context);
    } else if (id != UploadPage.id) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return IdToPage.idToPage(id);
        }),
      );
    }
  }

  gallery() {
    pickImage(ImageSource.gallery);
  }

  camera() {
    pickImage(ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(
        pageId: UploadPage.id,
        nvigate: nvigate,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gallery,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRow(
                child: GestureDetector(
                  onTap: openDrawer,
                  child: Icon(
                    Icons.menu,
                    size: UI.iconSize,
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
            child: Image.file(imageFile),
          ),
          SizedBox(
            height: 30.0,
          ),
          ImageTools(
            clear: clear,
            edit: edit,
            done: done,
          ),
        ],
      ),
    );
  }
}
