import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';
import 'package:intl/intl.dart';

final _loadingKey = GlobalKey<_DummyLoadingBuilderState>();

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
        onPressed: () => _loadingKey.currentState?.load(),
        child: const Icon(Icons.refresh),
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
      key: _loadingKey,
      duration: const Duration(seconds: 1),
      builder: (context, loading) => loading
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: _contents.length,
              itemBuilder: ((context, index) {
                return _AnimationItem(
                  index: index,
                  child: _ListItem(
                    data: _contents[index],
                  ),
                );
              }),
            ),
    );
  }
}

class _DummyLoadingBuilder extends StatefulWidget {
  const _DummyLoadingBuilder({
    super.key,
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

  void load() {
    setState(() {
      loading = true;
    });
    Future.delayed(widget.duration)
        .then((_) => setState(() => loading = false))
        .onError((_, __) => loading = false);
  }

  @override
  void initState() {
    super.initState();
    load();
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

class _AnimationItem extends StatefulWidget {
  const _AnimationItem({
    required this.child,
    required this.index,
  });

  final Widget child;
  final int index;

  @override
  State<_AnimationItem> createState() => __AnimationItemState();
}

class __AnimationItemState extends State<_AnimationItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 1 + widget.index * 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
