import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductoWidget extends StatelessWidget {
  const ProductoWidget({Key? key, required this.producto}) : super(key: key);
  final ProductoModel producto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
      height: ScreenUtil().setHeight(310),
      width: ScreenUtil().setWidth(200),
      decoration: BoxDecoration(
        color: colorSecond,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(16),
              left: ScreenUtil().setHeight(16),
              right: ScreenUtil().setHeight(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ScreenUtil().setHeight(180),
                  width: ScreenUtil().setWidth(168),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Container(
                          child: ShowLoadding(
                        active: true,
                        w: double.infinity,
                        h: double.infinity,
                        colorText: Colors.white,
                        fondo: Colors.transparent,
                      )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: 'https://productoftheyearusa.com/wp-content/uploads/2016/03/McN_POY_20158281.jpg',
                      //imageUrl: '$API_BASE_URL/${producto.productoImage}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(30),
                      child: SvgPicture.asset('assets/svg/bufi_coin.svg'),
                    ),
                    Text(
                      '${producto.productoPrice}',
                      style: TextStyle(
                        color: colorBlueText,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                Expanded(
                  child: Text(
                    '${producto.productoName}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${producto.productoBrand}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(50),
                decoration: BoxDecoration(
                  color: colorBlueText,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: ScreenUtil().setHeight(20),
                    width: ScreenUtil().setWidth(20),
                    child: SvgPicture.asset((producto.productoFavourite == '1') ? 'assets/svg/heart_white.svg' : 'assets/svg/tabInicio/heart_w.svg'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(50),
                decoration: BoxDecoration(
                  color: colorBlueText,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: ScreenUtil().setHeight(20),
                    width: ScreenUtil().setWidth(20),
                    child: SvgPicture.asset('assets/svg/tabInicio/shoping_car_w.svg'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
