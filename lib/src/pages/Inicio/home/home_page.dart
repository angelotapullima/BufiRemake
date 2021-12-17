import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/pantalla_principal_model.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:bufi_remake/src/widgets/nombre_widget.dart';
import 'package:bufi_remake/src/widgets/producto_widget.dart';
import 'package:bufi_remake/src/widgets/publicidad_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pantallaBloc = ProviderBloc.pantalla(context);
    pantallaBloc.obtenerPantallaPrincipal();
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: ScreenUtil().setHeight(24),
              width: ScreenUtil().setWidth(24),
              child: SvgPicture.asset('assets/svg/emoji_saludo.svg'),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(12),
            ),
            Text(
              'Hola, ',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            NombreWidget(),
          ],
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
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Container(
              height: ScreenUtil().setHeight(160),
              child: PublicidadWidget(),
            ),
            StreamBuilder(
              stream: pantallaBloc.pantallaStream,
              builder: (context, AsyncSnapshot<List<PantallaPrincipalModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    var datos = snapshot.data!;
                    return ListView.builder(
                      itemCount: datos.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(30),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${datos[index].nombre}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(16),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        'Ver todos',
                                        style: TextStyle(
                                          color: colorBlueText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(24),
                              ),
                              Container(
                                height: (datos[index].productos!.length > 0) ? ScreenUtil().setHeight(310) : 2,
                                child: ListView.builder(
                                  itemCount: datos[index].productos!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index2) {
                                    var producto = datos[index].productos![index2];
                                    return ProductoWidget(
                                      producto: producto,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('Sin datos');
                  }
                } else {
                  return ShowLoadding(
                    fondo: Colors.transparent,
                    w: double.infinity,
                    h: ScreenUtil().setHeight(180),
                    active: true,
                    colorText: Colors.white,
                  );
                }
              },
            ),
            SizedBox(
              height: ScreenUtil().setHeight(100),
            )
          ],
        ),
      ),
    );
  }
}
