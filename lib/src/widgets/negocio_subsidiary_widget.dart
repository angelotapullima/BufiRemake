import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:bufi_remake/src/pages/Negocio/Subsidiary/detalle_subsidiary.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NegocioSubsidiaryHorizontalWidget extends StatelessWidget {
  const NegocioSubsidiaryHorizontalWidget({Key? key, required this.subsidiary}) : super(key: key);
  final SubsidiaryModel subsidiary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(16)),
      height: ScreenUtil().setHeight(172),
      decoration: BoxDecoration(
        color: colorSecond,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalleSubsidiaryPage(
                      idSubsidiary: subsidiary.idSubsidiary.toString(),
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );

                    return SlideTransition(
                      position: animation.drive(tween),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(140),
                    width: ScreenUtil().setWidth(130),
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
                        //imageUrl: 'https://productoftheyearusa.com/wp-content/uploads/2016/03/McN_POY_20158281.jpg',
                        imageUrl: '$API_BASE_URL/${subsidiary.subsidiaryImg}',
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
                    width: ScreenUtil().setWidth(16),
                  ),
                  Column(
                    children: [
                      Text(
                        "${subsidiary.subsidiaryName}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(16),
                      ),
                      Center(
                        child: Text(
                          '${subsidiary.subsidiaryOpeningHours}',
                          style: TextStyle(
                            color: colorIcon,
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                //actualizarPointProducto(context, producto, (producto.productoFavourite == '1') ? '0' : '1');
              },
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
                    child:
                        SvgPicture.asset((subsidiary.subsidiaryFavourite == '1') ? 'assets/svg/heart_white.svg' : 'assets/svg/tabInicio/heart_w.svg'),
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
                    child: SvgPicture.asset('assets/svg/message-circle.svg'),
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
