import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onClick;

  const ListItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: IconButton(
              onPressed: () {
                onClick();
              },
              icon: const Icon(Icons.delete)),
        ),
      ),
    );
  }
}
