import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';
import 'package:intl/intl.dart';

class OffsetAndDelay extends StatelessWidget {
  const OffsetAndDelay({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: title,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: _OffsetAndDelayBody(),
      ),
    );
  }
}

enum _FileType {
  folder,
  file,
  photo,
}

extension on _FileType {
  IconData get icon {
    return {
      _FileType.folder: Icons.folder,
      _FileType.file: Icons.text_snippet,
      _FileType.photo: Icons.photo,
    }[this]!;
  }

  Color get color {
    return {
      _FileType.folder: Colors.blueGrey,
      _FileType.file: Colors.blueAccent,
      _FileType.photo: Colors.yellow,
    }[this]!;
  }
}

class _ContentData {
  const _ContentData({
    required this.fileName,
    required this.fileDetail,
    required this.fileType,
    required this.updateAt,
  });
  final _FileType fileType;
  final String fileName;
  final String fileDetail;
  final DateTime updateAt;
}

final _contents = [
  _ContentData(
    fileName: 'Photos',
    fileDetail: 'test',
    fileType: _FileType.folder,
    updateAt: DateTime.parse('20220202'),
  ),
  _ContentData(
    fileName: 'Replicas',
    fileDetail: 'test',
    fileType: _FileType.folder,
    updateAt: DateTime.parse('20220301'),
  ),
  _ContentData(
    fileName: 'Photo',
    fileDetail: 'test',
    fileType: _FileType.photo,
    updateAt: DateTime.parse('20220412'),
  ),
  _ContentData(
    fileName: 'File',
    fileDetail: 'test',
    fileType: _FileType.file,
    updateAt: DateTime.parse('20221111'),
  ),
];

class _OffsetAndDelayBody extends StatelessWidget {
  const _OffsetAndDelayBody();

  @override
  Widget build(BuildContext context) {
    return _DummyLoadingBuilder(
      duration: const Duration(seconds: 3),
      builder: (context, loading) => loading
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: _contents.length,
              itemBuilder: ((context, index) {
                return _ListItem(
                  data: _contents[index],
                );
              }),
            ),
    );
  }
}

class _DummyLoadingBuilder extends StatefulWidget {
  const _DummyLoadingBuilder({
    required this.builder,
    required this.duration,
  });

  final Widget Function(BuildContext, bool) builder;
  final Duration duration;

  @override
  State<_DummyLoadingBuilder> createState() => _DummyLoadingBuilderState();
}

class _DummyLoadingBuilderState extends State<_DummyLoadingBuilder> {
  late bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    Future.delayed(widget.duration)
        .then((_) => setState(() => loading = false))
        .onError((_, __) => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, loading);
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.data,
  });

  final _ContentData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: data.fileType.color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            data.fileType.icon,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.info),
        title: Text(data.fileName),
        subtitle: Text(DateFormat('yyyy/M/d').format(data.updateAt)),
      ),
    );
  }
}
