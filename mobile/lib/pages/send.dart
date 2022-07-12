/*
 * @file send.dart
 * @author Sciroccogti (scirocco_gti@yeah.net)
 * @brief 
 * @date 2022-07-12 14:54:47
 * @modified: 2022-07-12 14:55:03
 */

import 'package:flutter/material.dart';

class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send'),
      ),
      body: const Center(
        child: Text('Send'),
      ),
    );
  }
}