import 'package:flutter/material.dart';

import '../../constants.dart';

class AddClientPage extends StatefulWidget {
  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  final _requirementsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Client'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              fixedContainer(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
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
                        controller: _lastNameController,
                        decoration: inputDecoration('Last name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              fixedContainer(
                child: TextFormField(
                  controller: _emailController,
                  decoration: inputDecoration('Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              fixedContainer(
                child: TextFormField(
                    controller: _phoneController,
                    decoration: inputDecoration('Phone Number'),
                    validator: (value) {
                      if (!validPhoneNumberRegExp.hasMatch(value!)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null; // Return null if the phone number is valid
                    }),
              ),
              fixedContainer(
                child: TextFormField(
                    controller: _messageController,
                    decoration: inputDecoration('Phone Number'),
                    validator: (value) {
                      if (!validPhoneNumberRegExp.hasMatch(value!)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null; // Return null if the phone number is valid
                    }),
              ),
              fixedContainer(
                child: TextFormField(
                  controller: _requirementsController,
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 5,
                  decoration: inputDecoration('Requirements'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter requirements';
                    }
                    return null;
                  },
                ),
              ),
              Divider(),
              Center(
                child: Text('Search filter is taken from home screen'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            // Form is valid, perform save logic here
            saveForm();
          }
        },
        label: Text('Save'),
        icon: Icon(Icons.done),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Add email validation logic here (e.g., using regex)
    return true;
  }

  void saveForm() {
    // Implement your save logic here
    // Access form field values using the respective controllers:
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final message = _messageController.text;

    // Save data or navigate back
    // ...
  }
}

Container fixedContainer({required Widget child}) => Container(
      padding: const EdgeInsets.all(12),
      child: child,
    );

InputDecoration inputDecoration(String label) => InputDecoration(border: const OutlineInputBorder(), labelText: label);
