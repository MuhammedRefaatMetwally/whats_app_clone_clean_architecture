import 'package:advance_image_picker/configs/image_picker_configs.dart';
import 'package:advance_image_picker/models/image_object.dart';
import 'package:advance_image_picker/widgets/picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/camera_page/widgets/gallery_widget.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.cameras});
 final List<CameraDescription> cameras;
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  final configs = ImagePickerConfigs();
   late CameraController _cameraController ;

   List _galleryPhotos=[];

  @override
  void initState() {
    initializeCamera();
    getImagesFromGallery();
    super.initState();
  }

  Future<void> initializeCamera()async{
    _cameraController=CameraController(widget.cameras[0],ResolutionPreset.medium);
    await _cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

    @override
  void dispose(){
    _cameraController.dispose();
      super.dispose();
    }

  Future<void> getImagesFromGallery()async{
    configs.appBarTextColor = Colors.white;
    configs.appBarBackgroundColor = Colors.green;
    configs.translateFunc = (name, value) => Intl.message(value, name: name);
    final List<ImageObject>? objects = await Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
      return const ImagePicker(maxCount: 5);
    }));

    if ((objects?.length ?? 0) > 0) {
      setState(() {
        _galleryPhotos = objects!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GalleryWidget(galleryPhotos: _galleryPhotos,),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(_cameraController),
          ),
        ],
      ),
    );
  }



}

