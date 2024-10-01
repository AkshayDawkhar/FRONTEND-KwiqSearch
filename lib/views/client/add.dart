import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/controller/home.dart';

import '../../constants.dart';
import '../../controller/add_client.dart';

class AddClientPage extends StatelessWidget {
  var newClientController = Get.put(NewClientController());

  var filterController= Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Client'),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<NewClientController>(builder: (controller) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                fixedContainer(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.firstNameController,
                          decoration: inputDecoration('First name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.lastNameController,
                          decoration: inputDecoration('Last name'),
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter last name';
                            // }
                            // return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                fixedContainer(
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: inputDecoration('Email'),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter email';
                      // }
                      // // if (!isValidEmail(value)) {
                      // //   return 'Please enter a valid email';
                      // // }
                      // return null;
                    },
                  ),
                ),
                fixedContainer(
                  child: TextFormField(
                      controller: controller.phoneController,
                      decoration: inputDecoration('Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          // return 'Please enter phone number';
                          controller.phoneController.text = '0';
                        }
                        // if (!validPhoneNumberRegExp.hasMatch(value!)) {
                          // return 'Please enter a valid 10-digit phone number';
                          // controller.phoneController.text = '0';
                          // return null;
                        // }
                        return null; // Return null if the phone number is valid
                      }),
                ),
                fixedContainer(
                  child: TextFormField(
                      controller: controller.messageController,
                      decoration: inputDecoration('WhatsApp Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          // return 'Please enter phone number';
                          controller.messageController.text = '0';
                        }
                        // if (!validPhoneNumberRegExp.hasMatch(value!)) {
                        //   return 'Please enter a valid 10-digit phone number';
                        // }
                        // return null; // Return null if the phone number is valid
                      }),
                ),
                fixedContainer(
                  child: TextFormField(
                    controller: controller.requirementsController,
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 5,
                    decoration: inputDecoration('Requirements'),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter requirements';
                      // }
                      // return null;
                    },
                  ),
                ),
                Divider(),
                Center(
                  child: Text('Search filter is taken from home screen'),
                )
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (newClientController.formKey.currentState?.validate() == true) {
            // Form is valid, perform save logic here
            // saveForm();
          newClientController.getOutput(filterController.toMap(),filterController.selectedDurations);
          }
        },
        label: Text('Save'),
        icon: Icon(Icons.done),
      ),
      // bottomNavigationBar: bottomNavigationBar(index: 2,off: true),

    );
  }
}

Container fixedContainer({required Widget child}) => Container(
      padding: const EdgeInsets.all(12),
      child: child,
    );

InputDecoration inputDecoration(String label) => InputDecoration(border: const OutlineInputBorder(), labelText: label);
