import 'package:flutter/material.dart';
import 'package:sqf_sample_jan/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchDAta();
    super.initState();
  }

  fetchDAta() async {
    await HomeScreenController.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await HomeScreenController.addData();
          setState(() {});
        },
      ),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await HomeScreenController.getAllData();
                  setState(() {});
                },
                child: Text("get")),
            Column(
              children: List.generate(
                  HomeScreenController.data.length,
                  (index) => ListTile(
                        title: Text(HomeScreenController
                            .studentsList[index].name
                            .toString()),
                        subtitle: Text(HomeScreenController
                            .studentsList[index].ph
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await HomeScreenController.deleteData(
                                      HomeScreenController
                                          .studentsList[index].id);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () async {
                                  await HomeScreenController.editData(
                                      HomeScreenController
                                          .studentsList[index].id);
                                  setState(() {});
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
