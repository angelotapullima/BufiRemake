import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class ServicesCategoryPage extends StatelessWidget {
  const ServicesCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text('Servicios'),
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body: Container(
        child: Center(
          child: Text('ServicesCategoryPage'),
        ),
      ),
    );
  }
}