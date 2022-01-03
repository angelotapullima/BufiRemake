import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/pages/Productos/detail_producto_page.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductoWidget2 extends StatelessWidget {
  const ProductoWidget2({Key? key, required this.producto}) : super(key: key);
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 100),
              pageBuilder: (context, animation, secondaryAnimation) {
                return DetailProductoPage(producto: producto);
                //return DetalleProductitos(productosData: productosData);
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(16),
            left: ScreenUtil().setHeight(16),
            right: ScreenUtil().setHeight(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: ScreenUtil().setHeight(138),
                width: ScreenUtil().setWidth(124),
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
                height: ScreenUtil().setHeight(18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                '${producto.productoName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              Text(
                '${producto.productoBrand}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
