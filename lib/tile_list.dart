import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import 'package:download_file_from_server/my_provider.dart';


// Display each download items with download button(icon)


class TileList extends StatefulWidget {
  const TileList({super.key, required this.title, required this.url});

  final String? title;
  final String? url;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  String fileName = '';

  @override
  void didChangeDependencies() async {
    setState(() => fileName = path.basename(widget.url!));
    context.read<MyProvider>().checkFileExists(fileName);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title!),
      trailing: IconButton(
        onPressed: () async {
          MyProvider myProvider = context.read<MyProvider>();
          await myProvider.startDownloading(fileName, widget.url!);
        },
        icon: Consumer<MyProvider>(
          builder: (context, value, child) {
            return value.fileExists && value.downloading == false
                ? const Icon(Icons.save, color: Colors.green)
                : !value.downloading
                    ? const Icon(Icons.download, color: Colors.red)
                    : CircularProgressIndicator(
                        value: value.progressIndicatorValue,
                        color: Colors.grey,
                      );
          },
        ),
      ),
    );
  }
}
