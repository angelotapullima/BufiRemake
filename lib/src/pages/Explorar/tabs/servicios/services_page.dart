import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/ServicesCategoryPage.dart';
import 'package:bufi_remake/src/widgets/servicio_widget_2.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePageServices>(context, listen: false);
    final serviciosBloc = ProviderBloc.servicios(context);
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: ValueListenableBuilder<String>(
            valueListenable: provider.titulo3,
            builder: (_, value, __) {
              return Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
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
        leading: InkWell(
          onTap: () {
            provider.changePage(2);
            serviciosBloc.clearServicios();
          },
          child: Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24),
            ),
            height: ScreenUtil().setHeight(45),
            width: ScreenUtil().setWidth(45),
            child: SvgPicture.asset('assets/svg/back.svg'),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: serviciosBloc.servicioStream,
          builder: (context, AsyncSnapshot<List<ServicioModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                var datos = snapshot.data!;
                return GridView.builder(
                    itemCount: datos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: ScreenUtil().setWidth(10),
                    ),
                    itemBuilder: (_, index) {
                      return LayoutBuilder(builder: (context, constraints) {
                        return ServicioWidget2(
                          servicio: datos[index],
                        );
                      });
                    });
              } else {
                return Center(
                  child: Text(
                    'Sin servicios',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            } else {
              return ShowLoadding(
                fondo: Colors.transparent,
                w: double.infinity,
                h: double.infinity,
                active: true,
                colorText: Colors.white,
              );
            }
          }),
    );
  }
}
