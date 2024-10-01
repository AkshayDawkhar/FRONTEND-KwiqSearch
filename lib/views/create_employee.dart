import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/employee_controller.dart';

class CreateEmployeePage extends StatelessWidget {
  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username input field
              TextField(
                onChanged: (val) => employeeController.username.value = val,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter employee username',
                  errorText: employeeController.fieldErrors['username'],  // Show username error
                ),
              ),
              // Email input field
              TextField(
                onChanged: (val) => employeeController.email.value = val,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter employee email',
                  errorText: employeeController.fieldErrors['email'],  // Show email error
                ),
              ),
              // Password input field with "View Password" button
              TextField(
                obscureText: !employeeController.isPasswordVisible.value,
                onChanged: (val) => employeeController.password.value = val,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  errorText: employeeController.fieldErrors['password'],  // Show password error
                  suffixIcon: IconButton(
                    icon: Icon(employeeController.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      employeeController.togglePasswordVisibility();
                    },
                  ),
                ),
              ),
// User Type dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: employeeController.userType.value.isEmpty
                        ? null
                        : employeeController.userType.value,
                    hint: Text('Select User Type'),
                    items: employeeController.userTypes.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        employeeController.userType.value = newValue;
                      }
                    },
                  ),
                  // Error text for User Type
                  if (employeeController.fieldErrors['user_type'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        employeeController.fieldErrors['user_type']!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),

              // Locality dropdown
              DropdownButton<String>(
                value: employeeController.locality.value.isEmpty
                    ? null
                    : employeeController.locality.value,
                hint: Text('Select Locality'),
                items: employeeController.localities.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    employeeController.locality.value = newValue;
                  }
                },
              ),
              // Phone number input field
              TextField(
                onChanged: (val) => employeeController.phoneNumber.value = val,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  errorText: employeeController.fieldErrors['phone_number'],  // Show phone number error
                ),
              ),
              SizedBox(height: 20),
              // Display loading spinner if data is being processed
              employeeController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: employeeController.createEmployee,
                child: Text('Create Employee'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
