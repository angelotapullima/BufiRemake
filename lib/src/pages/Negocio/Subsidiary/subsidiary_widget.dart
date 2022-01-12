import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SubsidiaryWidget extends StatelessWidget {
  const SubsidiaryWidget({Key? key, required this.subsidiary}) : super(key: key);
  final SubsidiaryModel subsidiary;

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
          InkWell(
            onTap: () {},
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
                        // imageUrl: 'https://productoftheyearusa.com/wp-content/uploads/2016/03/McN_POY_20158281.jpg',
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
                    height: ScreenUtil().setHeight(18),
                  ),
                  Text(
                    '${subsidiary.subsidiaryName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                  Text(
                    '${subsidiary.subsidiaryOpeningHours}',
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
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                //actualizarPointServicio(context, servicio, (servicio.servicioFavourite == '1') ? '0' : '1');
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
        ],
      ),
    );
  }
}
