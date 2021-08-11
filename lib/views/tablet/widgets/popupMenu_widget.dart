import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContextMenuAction extends PopupMenuEntry<int> {
  @override
  double height = 100;

  @override
  bool represents(int n) => n == 1 || n == -1;

  @override
  ContextMenuActionState createState() => ContextMenuActionState();
}

class ContextMenuActionState extends State<ContextMenuAction> {
  void _view() {
    Navigator.pop<int>(context, 1);
  }

  void _download() {
    Navigator.pop<int>(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.visibility),
            title: Text('View'),
            onTap: _view,
            trailing: Icon(Icons.chevron_right)),
        ListTile(
            leading: Icon(Icons.download),
            title: Text('Download'),
            onTap: _download,
            trailing: Icon(Icons.chevron_right))
      ],
    );
  }
}

// ignore: must_be_immutable
class ContextSubMenuAction extends PopupMenuEntry<int> {
  @override
  double height = 100;

  @override
  bool represents(int n) => n == 1 || n == -1;

  @override
  ContextSubMenuActionState createState() => ContextSubMenuActionState();
}

class ContextSubMenuActionState extends State<ContextSubMenuAction> {
  void _view() {
    Navigator.pop<int>(context, 1);
  }

  void _download() {
    Navigator.pop<int>(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('View'),
        Divider(),
        ListTile(title: Text('PR-Paint Report'), onTap: _view),
        ListTile(title: Text('WL-WeldLog'), onTap: _download),
        ListTile(title: Text('FR-Final Report'), onTap: _download)
      ],
    );
  }
}

// ignore: must_be_immutable
class ContextSubMenuAction1 extends PopupMenuEntry<int> {
  @override
  double height = 100;

  @override
  bool represents(int n) => n == 1 || n == -1;

  @override
  ContextSubMenuAction1State createState() => ContextSubMenuAction1State();
}

class ContextSubMenuAction1State extends State<ContextSubMenuAction1> {
  void _view() {
    Navigator.pop<int>(context, 1);
  }

  void _download() {
    Navigator.pop<int>(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Download'),
        Divider(),
        ListTile(title: Text('PR-Paint Report'), onTap: _view),
        ListTile(title: Text('WL-WeldLog'), onTap: _download),
        ListTile(title: Text('FR-Final Report'), onTap: _download)
      ],
    );
  }
}
