/*
 * @file home.dart
 * @author Sciroccogti (scirocco_gti@yeah.net)
 * @brief 
 * @date 2022-07-12 11:59:51
 * @modified: 2022-07-12 11:59:58
 */
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}