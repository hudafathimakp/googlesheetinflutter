import 'package:flutter/material.dart';
import 'package:googlesheet_flutter/sheet.dart';



class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
List<List<String>> sheetData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await SheetsApi.writeToSheet(nameController.text,);
                      submitForm();

                      // List<List<String>> data = await SheetsApi.readFromSheet();
                      // print('Data from Google Sheets: $data');
                      // setState(() {
                      //   sheetData = data;
                      // });
                      //   @override
                      // void initState() {
                      //  sheetData = data; // call setState();
                      //   super.initState(); // then foo_bar()
                      // }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Name: ${nameController.text}, Email: ${emailController.text},');

      // clearForm();
      Navigator.pop(
        context,
        {
          //  sheetData
          'name': nameController.text,
          'email': emailController.text,
        },
      );
    }
  }

  void clearForm() {
    _formKey.currentState!.reset();
    nameController.clear();
    emailController.clear();
  }
}
