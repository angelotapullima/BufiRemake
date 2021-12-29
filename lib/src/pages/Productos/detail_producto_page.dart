import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DetailProductoPage extends StatelessWidget {
  final ProductoModel producto;
  const DetailProductoPage({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: ScreenUtil().setHeight(352),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(16),
                horizontal: ScreenUtil().setWidth(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().setWidth(45),
                      child: SvgPicture.asset('assets/svg/back.svg'),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: ScreenUtil().setHeight(39),
                      width: ScreenUtil().setWidth(39),
                      decoration: BoxDecoration(
                        color: colorBlueIcon,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Container(
                          height: ScreenUtil().setHeight(20),
                          width: ScreenUtil().setWidth(20),
                          child: SvgPicture.asset(
                              (producto.productoFavourite == '1') ? 'assets/svg/heart_white.svg' : 'assets/svg/tabInicio/heart_w.svg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
