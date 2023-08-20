import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/check_permission.dart';
import '/tile_list.dart';
import '/my_provider.dart';

// Show home screen with a widget for list of download items

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dataList = [
    {
      "id": "2",
      "title": "file Video 1",
      "url": "https://download.samplelib.com/mp4/sample-30s.mp4"
    },
    {
      "id": "3",
      "title": "file Video 2",
      "url": "https://download.samplelib.com/mp4/sample-20s.mp4"
    },
    {
      "id": "4",
      "title": "file Video 3",
      "url": "https://download.samplelib.com/mp4/sample-15s.mp4"
    },
    {
      "id": "5",
      "title": "file Video 4",
      "url": "https://download.samplelib.com/mp4/sample-10s.mp4"
    },
    {
      "id": "6",
      "title": "file PDF 6",
      "url":
          "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100080.pdf"
    },
    {
      "id": "10",
      "title": "file PDF 7",
      "url": "https://www.tutorialspoint.com/javascript/javascript_tutorial.pdf"
    },
    {
      "id": "10",
      "title": "C++ Tutorial",
      "url": "https://www.tutorialspoint.com/cplusplus/cpp_tutorial.pdf"
    },
    {
      "id": "11",
      "title": "file PDF 9",
      "url":
          "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100431.pdf"
    },
    {
      "id": "12",
      "title": "file PDF 10",
      "url": "https://www.tutorialspoint.com/java/java_tutorial.pdf"
    },
    {
      "id": "13",
      "title": "file PDF 12",
      "url": "https://www.irs.gov/pub/irs-pdf/p463.pdf"
    },
    {
      "id": "14",
      "title": "file PDF 11",
      "url": "https://www.tutorialspoint.com/css/css_tutorial.pdf"
    },
  ];

  bool permission = false;

  Future<void> checkPermission() async {
    bool isStorageAllow = await CheckPermission.checkStoragePermission();
    if (isStorageAllow) {
      permission = isStorageAllow;
      setState(() {});
    }
  }

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download File'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            String? title = dataList[index]['title'];
            String? url = dataList[index]['url'];
            return ChangeNotifierProvider(
              create: (context) => MyProvider(),
              builder: (context, child) => TileList(title: title, url: url),
            );
          },
        ),
      ),
    );
  }
}
