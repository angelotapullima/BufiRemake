import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text('Mi carrito'),
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body: Container(),
    );
  }
}
