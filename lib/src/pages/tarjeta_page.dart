import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text('Mi Bufi Card'),
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text(
          'Tarjeta',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
