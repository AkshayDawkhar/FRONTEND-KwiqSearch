import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/project.dart';

import '../../controller/image.dart';
import '../../controller/interested.dart';
import '../../model/add_project.dart';

class ImagePage extends StatefulWidget {
  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  var editProjectController = Get.put(EditProjectController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));
  var imageController = Get.put(ImageController(projectID: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  var interestedController = Get.put(InterestedController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<EditProjectController>(builder: (context) {
          return Text('${editProjectController.projectName.text}');
        }),
      ),
      body: GetBuilder<EditProjectController>(builder: (controller) {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async {
            controller.onInit();
          },
          child: SingleChildScrollView(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight, // Align items to the right bottom corner
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://media.istockphoto.com/id/511061090/photo/business-office-building-in-london-england.jpg?s=612x612&w=0&k=20&c=nYAn4JKoCqO1hMTjZiND1PAIWoABuy1BwH1MhaEoG6w=',
                      width: double.infinity,
                      // height: 200, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 1, // Adjust the position as needed
                    right: 1, // Adjust the position as needed
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle edit button press
                            // imagePickerDialog();
                            uploadProjectImage(89);
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                          child: Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete button press
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              GetBuilder<InterestedController>(builder: (controller) {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.units.length,
                    itemBuilder: (BuildContext context, int index) {
                      return unitContainer(controller.units.elementAt(index), index);
                    });
              }),
            ],
          )),
        );
      }),
    );
  }

  void cropImage() {
    //CroppedFile? cropped = await ImageCropper().cropImage(
    //     sourcePath: _pickedImage.path,
    //     aspectRatioPresets:
    //     [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //
    //     uiSettings: [
    //     AndroidUiSettings(
    //     toolbarTitle: 'Crop',
    //     cropGridColor: Colors.black,
    //     initAspectRatio: CropAspectRatioPreset.original,
    //     lockAspectRatio: false),
    //     IOSUiSettings
    // (title: 'Crop')]);

    // if (cropped != null) {
    // setState(() {
    // imageFile = File(cropped.path);
    // }
    // );
    // }
  }

  void uploadProjectImage(int id) async {
    File? pickedImage = await imagePickerDialog();
    print(pickedImage);
    if (pickedImage != null) {
      Get.dialog(AlertDialog(
        content: Image.file(pickedImage),
        actions: [
          TextButton(
              onPressed: () async {
                int i = await imageController.uploadImage(pickedImage);
                if (i == 201) {
                  Get.back();
                  setState(() {
                    print('setting state');
                  });
                }
                //
              },
              child: Text('Save'))
        ],
      ));
    }
  }

  void uploadUnitImage(Unit unit) async {
    File? pickedImage = await imagePickerDialog();
    if (pickedImage != null) {
      Get.dialog(AlertDialog(
        content: Image.file(pickedImage),
        actions: [
          TextButton(
              onPressed: () async {
                int i = await imageController.uploadUnitImage(pickedImage, unit.id);
                if (i == 201) {
                  Get.back();
                  setState(() {
                    print('setting state');
                  });
                }
              },
              child: Text('Save'))
        ],
      ));
    }
  }

  Future<File?> imagePickerDialog() async {
    var pickedImage;
    await Get.dialog(AlertDialog(
      title: Text('Change Image'),
      actions: [
        IconButton(
            onPressed: () async {
              pickedImage = pickImage(ImageSource.camera);
              Get.back();
            },
            icon: Icon(Icons.camera)),
        IconButton(
            onPressed: () {
              pickedImage = pickImage(ImageSource.gallery);
              Get.back();
            },
            icon: Icon(Icons.folder)),
      ],
    ));
    return pickedImage;
  }

  Future<File?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      File _pickedImage = File(pickedImage.path);
      return _pickedImage;
    }
    return null;
  }

  Widget unitContainer(Unit unit, int index) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2),
        color: Colors.blue[200],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' ${unitToName(unit.unit)} | ${unit.carpetArea} sqft | ${numberToLCr(unit.price.toDouble())}'),
              IconButton(
                  onPressed: () {
                    uploadUnitImage(unit);
                  },
                  color: Colors.black,
                  icon: Icon(Icons.add_photo_alternate))
            ],
          ),
          unit.floorMap.isNotEmpty
              ? Stack(
                  alignment: Alignment.bottomRight, // Align items to the right bottom corner
                  children: [
                    InkWell(
                      onTap: (){

                        print(unit.floorMap.firstOrNull!.image);
                        Get.dialog(
                          InteractiveViewer(
                            clipBehavior: Clip.none,
                            maxScale: 90,
                            child: Image.network('$HOSTNAME${unit.floorMap.first.image}'),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '$HOSTNAME${unit.floorMap.first.image}',
                          width: double.infinity,
                          // height: 200, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1, // Adjust the position as needed
                      right: 1, // Adjust the position as needed
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle edit button press
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                            child: Icon(Icons.delete),
                            onPressed: () {
                              // imageController.deleteUnitImage();
                              // Handle delete button press
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
