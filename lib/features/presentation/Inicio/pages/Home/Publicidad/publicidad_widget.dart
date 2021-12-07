import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/core/widgets/connection_error.dart';
import 'package:bufi_remake/core/widgets/progress.dart';
import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';
import 'package:bufi_remake/features/presentation/Inicio/blocs/publicidad/publicidad_bloc.dart';
import 'package:bufi_remake/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Publicidad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PublicidadBloc>()..add(GetPublicidadBlocEvent()),
      child: BlocBuilder<PublicidadBloc, PublicidadState>(
        builder: (context, state) {
          if (state is Empty) {
            return SizedBox(
              height: 50,
              child: Text('Vacío'),
            );
          } else if (state is Loading) {
            return SizedBox(
              height: ScreenUtil().setHeight(160),
              child: Progress(),
            );
          } else if (state is ListarPublicidad) {
            return Container(
              child: _listarPublicidad(state.listPublicidad),
            );
          } else if (state is Error) {
            return SizedBox(
              height: ScreenUtil().setHeight(160),
              child: ConnectionError(),
            );
          } else {
            return SizedBox(
              height: ScreenUtil().setHeight(160),
              child: Center(
                child: Text(
                  'Ocurrió un error desconocido',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _listarPublicidad(List<PublicidadEntities> publicidad) {
    return CarouselSlider.builder(
      itemCount: publicidad.length,
      itemBuilder: (context, x, y) {
        return InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(0),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: 'publi-${publicidad[x].idPublicidad}',
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Text('Cargando'),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                  imageUrl: '$API_BASE_URL/${publicidad[x].publicidadImagen}',
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
        viewportFraction: 0.8,
      ),
    );
  }
}
