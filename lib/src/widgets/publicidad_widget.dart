import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/publicidad_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublicidadWidget extends StatelessWidget {
  const PublicidadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final publicidadBloc = ProviderBloc.publi(context);
    publicidadBloc.obtenerPublicidad();
    return StreamBuilder(
        stream: publicidadBloc.publicidadStream,
        builder: (_, AsyncSnapshot<List<PublicidadModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var datos = snapshot.data;
              return CarouselSlider.builder(
                itemCount: datos!.length,
                itemBuilder: (context, x, y) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(0),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Hero(
                              tag: 'publi-${datos[x].idPublicidad}',
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                                imageUrl: '$API_BASE_URL/${datos[x].publicidadImagen}',
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                    height: ScreenUtil().setHeight(160),
                    onPageChanged: (index, page) {},
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: Duration(seconds: 6),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    viewportFraction: 0.8),
              );
            } else {
              return Container();
            }
          } else {
            return ShowLoadding(
              active: true,
              w: double.infinity,
              h: double.infinity,
              colorText: Colors.white,
              fondo: Colors.transparent,
            );
          }
        });
  }
}
