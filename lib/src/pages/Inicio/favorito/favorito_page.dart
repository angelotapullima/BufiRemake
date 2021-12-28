import 'package:bufi_remake/core/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: Text(
          'Mis favoritos',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            height: ScreenUtil().setHeight(40),
            width: ScreenUtil().setWidth(40),
            child: SvgPicture.asset('assets/svg/search.svg'),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
