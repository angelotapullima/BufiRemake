import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/core/util/utils.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiciosHorizontalWidget extends StatelessWidget {
  const ServiciosHorizontalWidget({Key? key, required this.servicio}) : super(key: key);
  final ServicioModel servicio;

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
            onTap: () {},
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
                        imageUrl: '$API_BASE_URL/${servicio.servicioImage}',
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
                        "${servicio.servicioName}",
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
                      Text(
                        '${servicio.servicioDescription}',
                        style: TextStyle(
                          color: colorIcon,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
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
                            '${servicio.servicioPrice}',
                            style: TextStyle(
                              color: colorBlueText,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ],
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
                actualizarPointServicio(context, servicio, (servicio.servicioFavourite == '1') ? '0' : '1');
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
                    child: SvgPicture.asset((servicio.servicioFavourite == '1') ? 'assets/svg/heart_white.svg' : 'assets/svg/tabInicio/heart_w.svg'),
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
