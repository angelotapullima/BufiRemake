import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF152535),
      appBar: AppBar(
        backgroundColor: Color(0XFF152535),
        title: Text('Hola, Bufeo'),
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
