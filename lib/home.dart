import 'package:flutter/material.dart';
import 'package:googlesheet_flutter/form_list.dart';
import 'package:googlesheet_flutter/sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<List<String>> sheetData = [];
bool _isLoading = true;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final data = await SheetsApi.readFromSheet();
      setState(() {
        sheetData = data;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> loadData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final data = await SheetsApi.readFromSheet();
  //   setState(() {
  //     sheetData = data;
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Example'),
      ),
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: sheetData.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    
                    // subtitle: Text(details[index]['email']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            String newValue = await showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController controller =
                                    TextEditingController();

                                return AlertDialog(
                                  title: const Text('Edit Value'),
                                  content: TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      labelText: 'New Value',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, null);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await SheetsApi.editItem(
                                            index + 1, controller.text);
                                        Navigator.pop(context, controller.text);

                                        loadData();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );

                            // if (newValue != null) {
                            //   await SheetsApi.editItem(index + 1, newValue);

                            //   loadData();
                            // }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await SheetsApi.deleteRow(index + 1);
                            loadData();
                          },
                        ),
                      ],
                    ),
                    title: Text(sheetData[index].join(', ').toString()),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              // gradient: primaryColor,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyForm(),
              ),
            ).then((newUserData) {
              // Handle the data returned from the form and add it to the list
              if (newUserData != null) {
                setState(() {
                  // sheetData.add(newUserData);
                  loadData();
                });
              }
            });
          }),
    );
  }
}
