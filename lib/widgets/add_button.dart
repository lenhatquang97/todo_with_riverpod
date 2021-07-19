import 'package:flutter/material.dart';

import '../constants.dart';
class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 10,
        height: 40,
        padding: const EdgeInsets.all(10),
        color: Colors.blue,
        child: const Center(
            child: Text('Add', style: kSmallWhiteText)));
  }
}
