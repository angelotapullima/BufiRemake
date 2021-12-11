import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NombreWidget extends StatefulWidget {
  NombreWidget({Key? key}) : super(key: key);

  @override
  _NombreWidgetState createState() => _NombreWidgetState();
}

class _NombreWidgetState extends State<NombreWidget> {
  String nombre = '';
  @override
  void initState() {
    firstName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      nombre,
      style: TextStyle(
        color: Colors.white,
        fontSize: ScreenUtil().setSp(18),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void firstName() async {
    String? nomb = await StorageManager.readData('personName');
    if (nomb!.length > 0) {
      var nombres = nomb.split(' ');
      print(nombres[0]);
      nombre = nombres[0];
      setState(() {});
    }
  }
}
