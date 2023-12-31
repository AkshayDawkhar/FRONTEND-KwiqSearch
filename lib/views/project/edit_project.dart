import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/project.dart';

class EditProject extends StatelessWidget {
  var editProjectController = Get.put(EditProjectController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  @override
  Widget build(BuildContext context) {
    Widget myContainer(int index) {
      return fixedContainer(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Enter something";
                    }
                    return null;
                  },
                  decoration: inputDecoration('BHK'),
                  value: double.tryParse(editProjectController.units.elementAt(index)['unit']!.text),
                  hint: const Text('BHK'),
                  items: bhks,
                  onChanged: (value) {
                    editProjectController.units.elementAt(index)['unit']!.text = value.toString();
                  }),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter something";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: inputDecoration('Carpet Area'),
                controller: editProjectController.units.elementAt(index)['CarpetArea'],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter something";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                // decoration: inputDecoration('Price ₹ in L'),
                decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder(), suffixText: 'L'),
                controller: editProjectController.units.elementAt(index)['price'],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'interested') {
                Get.toNamed('/interested',parameters: {'project_id':editProjectController.projectId.toString()});
                // Handle edit action here
                // For example, navigate to edit user screen
              }else if (value == 'image') {
                Get.toNamed('/image',parameters: {'project_id':editProjectController.projectId.toString()});
                // Handle edit action here
                // For example, navigate to edit user screen
              } else if (value == 'delete') {
                // Handle delete action here
                // For example, show a confirmation dialog
                // clientController.deleteClient();
                Get.defaultDialog(
                  title: 'Confirmation',
                  middleText: 'Sure delete?',
                  // confirmTextColor: Colors.white,
                  onConfirm: () {
                    // Perform delete action here
                    // clientController.deleteClient();
                    print('Delete action confirmed!');
                  },
                  onCancel: () {
                    // Handle the cancel action here (if needed)
                    print('Delete action canceled!');
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'interested',
                child: ListTile(leading: Icon(Icons.person_search), iconColor: Colors.blueAccent, title: Text('Interested')),
              ),
              PopupMenuItem<String>(
                value: 'image',
                child: ListTile(leading: Icon(Icons.image), iconColor: Colors.blueAccent, title: Text('Images')),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(leading: Icon(Icons.delete), iconColor: Colors.red, title: Text('Delete')),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<EditProjectController>(builder: (controller) {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async {
            controller.onInit();
          },
          child: SingleChildScrollView(
            child: Form(
                key: controller.fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    fixedContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return 'Enter something';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration('Area'),
                                hint: const Text('Area'),
                                items: controller.areas,
                                value: controller.area.text == '' ? null : controller.area.text,
                                onChanged: (value) {
                                  controller.area.text = value!;
                                }),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          IconButton(
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  title: const Text('Add Area'),
                                  content: Form(
                                    key: controller.fromKeyAdd,
                                    child: TextFormField(
                                      controller: controller.addArea,
                                      decoration: inputDecoration('Name'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter a name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('cancel')),
                                    TextButton(
                                        onPressed: () {
                                          if (controller.fromKeyAdd.currentState!.validate()) {
                                            controller.addName(controller.addArea.text);
                                            controller.addNewArea(controller.addArea.text);
                                            // Get.back();
                                          }
                                        },
                                        child: const Text('Save'))
                                  ],
                                ));
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      decoration: inputDecoration('Project Name'),
                      controller: controller.projectName,
                    )),
                    fixedContainer(
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter something";
                            }
                            return null;
                          },
                          decoration: inputDecoration('Project Type'),
                          hint: const Text('Project Type'),
                          value: controller.projectType.text == '' ? null : controller.projectType.text,
                          items: projectType
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e.toLowerCase(),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            controller.projectType.text = value!;
                          }),
                    ),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      decoration: inputDecoration('Developer Name'),
                      controller: controller.developerName,
                    )),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration('Land Parcel'),
                      controller: controller.landParcel,
                    )),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      decoration: inputDecoration('Nearing Landmark'),
                      controller: controller.landmark,
                    )),
                    fixedContainer(
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter something";
                            }
                            return null;
                          },
                          decoration: inputDecoration('Area In'),
                          hint: const Text('Area In'),
                          items: areaIn
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e.toLowerCase(),
                                  ))
                              .toList(),
                          value: controller.areaIn.text == '' ? null : controller.areaIn.text,
                          onChanged: (value) {
                            controller.areaIn.text = value!;
                          }),
                    ),
                    fixedContainer(
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter something";
                            }
                            return null;
                          },
                          decoration: inputDecoration('Water Supply'),
                          hint: const Text('Water Supply'),
                          value: controller.waterSupply.text == '' ? null : controller.waterSupply.text,
                          items: waterConnection
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e.toLowerCase(),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            controller.waterSupply.text = value!;
                          }),
                    ),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration('Lifts'),
                      controller: controller.lifts,
                    )),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration('Floors'),
                      controller: controller.floors,
                    )),
                    fixedContainer(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter something";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration('Flats per Floors'),
                      controller: controller.flatsPerFloors,
                    )),
                    fixedContainer(
                      child: Row(
                        children: [
                          Expanded(
                            // flex: 4,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration('Total Unit'),
                              controller: controller.totalUnit,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            // flex: 4,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration('Available Unit'),
                              controller: controller.availableUnit,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      value: controller.readyToMove,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        controller.setReadyToMove(value!);
                      },
                      // secondary: Icon(Icons.),
                      title: const Text('Ready to Move'),
                    ),
                    controller.readyToMove
                        ? const Text('Ready To Move')
                        : fixedContainer(
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return "Enter something";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration('Month'),
                                      value: controller.reraMonth,
                                      hint: const Text('RERA'),
                                      items: months,
                                      onChanged: (value) {
                                        controller.reraMonth = value!;
                                      }),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return "Enter something";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration('YEAR'),
                                      value: controller.reraYear,
                                      hint: const Text('RERA'),
                                      items: years.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                                      onChanged: (value) {
                                        controller.reraYear = value!;
                                      }),
                                ),
                              ],
                            ),
                          ),
                    controller.readyToMove
                        ? const Text('Ready To Move')
                        : fixedContainer(
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return "Enter something";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration('Month'),
                                      // value:
                                      hint: const Text('Developer'),
                                      items: months,
                                      value: controller.developerMonth,
                                      onChanged: (value) {
                                        // controller.rera = value;
                                        controller.developerMonth = value!;
                                      }),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                      value: controller.developerYear,
                                      validator: (value) {
                                        if (value == null) {
                                          return "Enter something";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration('YEAR'),
                                      hint: const Text('Developer'),
                                      items: years.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                                      onChanged: (value) {
                                        controller.developerYear = value!;
                                        // controller.amenities.text = value.toString();
                                      }),
                                ),
                              ],
                            ),
                          ),
                    fixedContainer(
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter something";
                            }
                            return null;
                          },
                          decoration: inputDecoration('Amenities'),
                          value: controller.amenities.text == '' ? null : controller.amenities.text,
                          hint: const Text('Amenities'),
                          items: amenities.map((e) {
                            print(controller.amenities);
                            return DropdownMenuItem(value: e.toLowerCase(), child: Text(e));
                          }).toList(),
                          onChanged: (value) {
                            controller.amenities.text = value.toString();
                          }),
                    ),
                    fixedContainer(
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter something";
                            }
                            return null;
                          },
                          decoration: inputDecoration('Parking'),
                          value: controller.parking.text == '' ? null : controller.parking.text,
                          hint: const Text('Parking'),
                          items: parking.map((e) => DropdownMenuItem(value: e.toLowerCase(), child: Text(e))).toList(),
                          onChanged: (value) {
                            controller.parking.text = value.toString();
                          }),
                    ),
                    CheckboxListTile(
                      value: controller.transport,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        controller.setTransport(value!);
                      },
                      secondary: const Icon(Icons.directions_bus_sharp),
                      title: const Text('Public Transport'),
                    ),
                    CheckboxListTile(
                      value: controller.power,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        controller.setPower(value!);
                      },
                      secondary: const Icon(Icons.power),
                      title: const Text('Power Backup (Full Building Back up)'),
                    ),
                    CheckboxListTile(
                      value: controller.goods,
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: const Icon(Icons.grid_on_outlined),
                      onChanged: (value) {
                        controller.setGoods(value!);
                      },
                      // secondary: Icon(Icons.),
                      title: const Text('White Goods'),
                    ),
                    fixedContainer(
                      child: Row(
                        children: [
                          Expanded(
                            // flex: 4,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                              // keyboardType: TextInputType.number,
                              decoration: inputDecoration('Contact Person'),
                              controller: controller.contactPerson,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration('Contact Number'),
                              controller: controller.contactNumber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    fixedContainer(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter something";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Market Value', border: OutlineInputBorder(), suffixText: 'Cr'),
                        controller: controller.marketValue,
                      ),
                    ),
                    fixedContainer(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter something";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration('CP brokerage '),
                        controller: controller.brokerage,
                      ),
                    ),
                    fixedContainer(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter something";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration('executive incentive'),
                        controller: controller.incentive,
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.units.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return myContainer(index);
                        }),
                    const Divider(),
                    fixedContainer(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Add units'),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.removeUnit();
                                },
                                icon: const Icon(Icons.remove)),
                            IconButton(
                                onPressed: () {
                                  controller.addUnit();
                                },
                                icon: const Icon(Icons.add)),
                          ],
                        ),
                      ],
                    )),
                    fixedContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration('latitude'),
                              controller: controller.latitude,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration('longitude'),
                              controller: controller.longitude,
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.location_searching))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    fixedContainer(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                            // return "Enter something";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        decoration: inputDecoration('Link'),
                        controller: controller.urlController,
                      ),
                    ),
                    SizedBox(
                        height: 200,
                        child: fixedContainer(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Enter something";
                            //   }
                            //   return null;
                            // },
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            // keyboardType: TextInputType.number,
                            decoration: inputDecoration('OutPut'),
                            controller: controller.output,
                          ),
                        )),
                  ],
                )),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          if (editProjectController.fromKey.currentState!.validate()) {
            Get.dialog(AlertDialog(
              title: const Text('Conform save'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();

                      editProjectController.saveAndEdit();
                    },
                    child: const Text('Save and Add Unit')),
                TextButton(
                    onPressed: () {
                      // editProductController.getOutput();
                      editProjectController.editProject();
                      Get.back();
                      // Get.back();
                    },
                    child: const Text('Save'))
              ],
            ));
          }
          // newProductController.saveAndEdit();
        },
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
      // bottomNavigationBar: bottomNavigationBar(index: 1,off: true),

    );
  }
}

Container fixedContainer({required Widget child}) => Container(
      padding: const EdgeInsets.all(12),
      child: child,
    );

InputDecoration inputDecoration(String label) => InputDecoration(border: const OutlineInputBorder(), labelText: label);
AlertDialog saveDialog = AlertDialog(
  title: const Text('Conform save'),
  actions: [
    TextButton(onPressed: () {}, child: const Text('Save and Add Unit')),
    TextButton(
        onPressed: () {
          Get.back();
          // Get.back();
        },
        child: const Text('Save'))
  ],
);
