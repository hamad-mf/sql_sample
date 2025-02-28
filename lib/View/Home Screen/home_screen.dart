import 'package:flutter/material.dart';
import 'package:sql_sample/Controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await HomeScreenController.getAllEmoloyee();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        
        customBottomSheet(context);
      }),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(HomeScreenController.employeeList[index]["name"]),
                subtitle: Text(
                    HomeScreenController.employeeList[index]["designation"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () async {
                          customBottomSheet(context,
                              isEdit: true,
                              currentName: HomeScreenController
                                  .employeeList[index]["name"],
                              currentDes: HomeScreenController
                                  .employeeList[index]["designation"],
                                  employeeid: HomeScreenController
                                  .employeeList[index]["id"]);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          await HomeScreenController.removeEmployee(
                              HomeScreenController.employeeList[index]["id"]);
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: HomeScreenController.employeeList.length),
    );
  }

  Future<dynamic> customBottomSheet(BuildContext context,
      {bool isEdit = false, String? currentName, String? currentDes ,int? employeeid}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController desController = TextEditingController();

    if (isEdit) {
      nameController.text = currentName ?? "";
      desController.text = currentDes ?? "";
    }

    return showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "name", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: desController,
                    decoration: InputDecoration(
                        labelText: "Designation", border: OutlineInputBorder()),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"))),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (isEdit) {
                                  await HomeScreenController.updateEmployee(
                                      nameController.text, desController.text,employeeid!);
                                  setState(() {});
                                  Navigator.pop(context);
                                }else{
                                  await HomeScreenController.addEmployee(
                                      nameController.text, desController.text);
                                  setState(() {});
                                  Navigator.pop(context);
                                }
                                
                              },
                              child: Text("Save")))
                    ],
                  )
                ],
              ),
            ));
  }
}
