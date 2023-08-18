import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/project.dart';
import 'package:takeahome/model/project.dart' as project;

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
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          imageController.getProjectImage(editProjectController.projectId);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(' Images'),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        uploadProjectImage(editProjectController.projectId);
                                      },
                                      icon: Icon(Icons.add_photo_alternate))
                                ],
                              ),
                              Expanded(
                                child: GetBuilder<ImageController>(
                                    init: ImageController(projectID: editProjectController.projectId),
                                    builder: (controller) {
                                      return GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                          shrinkWrap: true,
                                          itemCount: controller.projectImages.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            project.ProjectImage image = controller.projectImages.elementAt(index);
                                            return Container(
                                              padding: EdgeInsets.all(6),
                                              child: Stack(
                                                alignment: Alignment.bottomRight, // Align items to the right bottom corner
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.dialog(
                                                        InteractiveViewer(
                                                          clipBehavior: Clip.none,
                                                          maxScale: 90,
                                                          child: Image.network(
                                                            '$HOSTNAME${image.image}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Image.network(
                                                        '$HOSTNAME${image.image}',
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
                                                            // imageController.updateImage(ima, imageID)
                                                            updateProjectImage(editProjectController.projectId, image.id);
                                                          },
                                                          child: Icon(Icons.edit),
                                                        ),
                                                        SizedBox(width: 10),
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                                                          child: Icon(Icons.delete),
                                                          onPressed: () {
                                                            imageController.deleteProjectImage(image.id);
                                                            Navigator.pop(context);
                                                            editProjectController.onInit();
                                                            setState(() {});
                                                            // Handle delete button press
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }),
                              ),
                            ],
                          );
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network('${editProjectController.imageUrl}'),
                  ),
                ),
                GetBuilder<InterestedController>(builder: (controller) {
                  return Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.units.length,
                        itemBuilder: (BuildContext context, int index) {
                          return unitContainer(controller.units.elementAt(index), index);
                        }),
                  );
                }),
                SizedBox(
                  height: 500,
                )
                // Stack(
                //   alignment: Alignment.bottomRight, // Align items to the right bottom corner
                //   children: [
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(12),
                //       child: Image.network(
                //         'https://media.istockphoto.com/id/511061090/photo/business-office-building-in-london-england.jpg?s=612x612&w=0&k=20&c=nYAn4JKoCqO1hMTjZiND1PAIWoABuy1BwH1MhaEoG6w=',
                //         width: double.infinity,
                //         // height: 200, // Adjust the height as needed
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //     Positioned(
                //       bottom: 1, // Adjust the position as needed
                //       right: 1, // Adjust the position as needed
                //       child: Row(
                //         children: [
                //           ElevatedButton(
                //             onPressed: () {
                //               // Handle edit button press
                //               // imagePickerDialog();
                //               uploadProjectImage(89);
                //             },
                //             child: Icon(Icons.edit),
                //           ),
                //           SizedBox(width: 10),
                //           ElevatedButton(
                //             style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                //             child: Icon(Icons.delete),
                //             onPressed: () {
                //               // Handle delete button press
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // Divider(),
                // GetBuilder<InterestedController>(builder: (controller) {
                //   return SizedBox(
                //     height: 120,
                //     child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: controller.units.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return unitContainer(controller.units.elementAt(index), index);
                //         }),
                //   );
                // }),
              ],
            ),
          ),
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
                int i = await imageController.uploadImage(pickedImage, editProjectController.projectId);
                if (i == 201) {
                  Get.back();
                  editProjectController.onInit();
                  // setState(() {
                  //   print('setting state');
                  // });
                }
                //
              },
              child: Text('Save'))
        ],
      ));
    }
  }

  void updateProjectImage(int projectID, int id) async {
    File? pickedImage = await imagePickerDialog();
    print(pickedImage);
    if (pickedImage != null) {
      Get.dialog(AlertDialog(
        content: Image.file(pickedImage),
        actions: [
          TextButton(
              onPressed: () async {
                int i = await imageController.updateImage(pickedImage, projectID, id);
                if (i == 201) {
                  Get.back();
                  editProjectController.onInit();
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

  void updateUnitImage(int projectID, int id) async {
    File? pickedImage = await imagePickerDialog();
    print(pickedImage);
    if (pickedImage != null) {
      Get.dialog(AlertDialog(
        content: Image.file(pickedImage),
        actions: [
          TextButton(
              onPressed: () async {
                int i = await imageController.updateUnitImage(pickedImage, projectID, id);
                if (i == 201) {
                  Get.back();
                  editProjectController.onInit();
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
                  editProjectController.onInit();
                  Get.back();
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
    print('----');
    print(unit.floorMap.firstOrNull.runtimeType);
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
        color: Colors.blue[200],
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                imageController.getUnitImage(unit.id);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(' Unit Images'),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              uploadUnitImage(unit);
                            },
                            icon: Icon(Icons.add_photo_alternate))
                      ],
                    ),
                    Expanded(
                      child: GetBuilder<ImageController>(
                          init: ImageController(projectID: editProjectController.projectId),
                          builder: (controller) {
                            return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                shrinkWrap: true,
                                itemCount: controller.unitImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  project.FloorMap image = controller.unitImages.elementAt(index);
                                  return Container(
                                    padding: EdgeInsets.all(6),
                                    child: Stack(
                                      alignment: Alignment.bottomRight, // Align items to the right bottom corner
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.dialog(
                                              InteractiveViewer(
                                                clipBehavior: Clip.none,
                                                maxScale: 90,
                                                child: Image.network(
                                                  '$HOSTNAME${image.image}',
                                                ),
                                              ),
                                            );
                                          },
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.network(
                                              '$HOSTNAME${image.image}',
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
                                                  // imageController.updateImage(ima, imageID)
                                                  updateUnitImage(unit.id, image.id);
                                                },
                                                child: Icon(Icons.edit),
                                              ),
                                              SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                                                child: Icon(Icons.delete),
                                                onPressed: () {
                                                  imageController.deleteUnitImage(image.id);
                                                  Navigator.pop(context);
                                                  editProjectController.onInit();
                                                  setState(() {});
                                                  // Handle delete button press
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                    ),
                  ],
                );
              }); // interestedController.switchUnit(index, unit.id);
        },
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(unitToName(unit.unit)),
              Text('${unit.carpetArea} sqft'),
              Text(numberToLCr(unit.price.toDouble())),
            ],
          ),
        ),
      ),
    );
  }
}

// class BottomEditProjectImageDialog extends StatelessWidget {
//   int id;
//
//   BottomEditProjectImageDialog({Key? key, required this.id}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var imageController = Get.put(ImageController(projectID: id));
//     imageController.getProjectImage(id);
//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(' Images'),
//               IconButton(onPressed: (){
//               }, icon: Icon(Icons.add_photo_alternate))
//             ],
//           ),
//           Expanded(
//             child: GetBuilder<ImageController>(
//                 init: ImageController(projectID: id),
//                 builder: (controller) {
//                   return GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                       shrinkWrap: true,
//                       itemCount: controller.projectImages.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         project.ProjectImage image = controller.projectImages.elementAt(index);
//                         return Container(
//                           padding: EdgeInsets.all(6),
//                           child: Stack(
//                             alignment: Alignment.bottomRight, // Align items to the right bottom corner
//                             children: [
//                               Image.network(
//                                 '$HOSTNAME${image.image}',
//                                 fit: BoxFit.cover,
//                               ),
//                               Positioned(
//                                 bottom: 1, // Adjust the position as needed
//                                 right: 1, // Adjust the position as needed
//                                 child: Row(
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () {},
//                                       child: Icon(Icons.edit),
//                                     ),
//                                     SizedBox(width: 10),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
//                                       child: Icon(Icons.add),
//                                       onPressed: () {
//                                         // Handle delete button press
//                                    Get.dialog(AlertDialog(title: Text('Area you sure'),));
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       });
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
