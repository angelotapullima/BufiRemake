import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';


class CompanyExplorer extends StatelessWidget {
  const CompanyExplorer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text('Negocios'),
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body:  Container(
        child: Center(
          child: Text('CompanyExplorer'),
        ),
      ),
    );
  }
}