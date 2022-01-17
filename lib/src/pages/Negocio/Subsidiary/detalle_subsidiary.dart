import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:bufi_remake/src/pages/Negocio/Subsidiary/tabs/informacion_subsidiary.dart';
import 'package:bufi_remake/src/pages/Negocio/Subsidiary/tabs/productos_subsidiary.dart';
import 'package:bufi_remake/src/pages/Negocio/Subsidiary/tabs/resenhas_subsidiary.dart';
import 'package:bufi_remake/src/pages/Negocio/Subsidiary/tabs/servicios_subsidiary.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetalleSubsidiaryPage extends StatefulWidget {
  const DetalleSubsidiaryPage({Key? key, required this.idSubsidiary}) : super(key: key);
  final String idSubsidiary;

  @override
  State<DetalleSubsidiaryPage> createState() => _DetalleSubsidiaryPageState();
}

class _DetalleSubsidiaryPageState extends State<DetalleSubsidiaryPage> with TickerProviderStateMixin {
  List<Widget> pageList = [];
  final List<Widget> listTexto = [];
  TabController? tabcontroller;
  @override
  void initState() {
    pageList.add(InformacionSubsidiaryPage());
    pageList.add(ProductosSubsidiaryPage(idSubsidiary: widget.idSubsidiary));
    pageList.add(ServiciosSubsidiaryPage(idSubsidiary: widget.idSubsidiary));
    pageList.add(ResenhasSubsidiaryPage(idSubsidiary: widget.idSubsidiary));
    listTexto.add(Tab(text: 'Infromación'));
    listTexto.add(Tab(text: 'Productos'));
    listTexto.add(Tab(text: 'Servicios'));
    listTexto.add(Tab(text: 'Reseñas'));
    super.initState();

    tabcontroller = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    final subsidiaryBloc = ProviderBloc.subsidiary(context);
    subsidiaryBloc.obtenerSubsidiariesByIdSubsidiary(widget.idSubsidiary);
    return Scaffold(
      backgroundColor: colorPrimary,
      body: StreamBuilder(
        stream: subsidiaryBloc.subsidiaryIdStream,
        builder: (_, AsyncSnapshot<List<SubsidiaryModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var subsidiary = snapshot.data![0];
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(352),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              width: ScreenUtil().setWidth(60),
                              height: ScreenUtil().setHeight(60),
                              child: SvgPicture.asset(
                                'assets/svg/bufi.svg',
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              child: Container(
                                width: ScreenUtil().setWidth(60),
                                height: ScreenUtil().setHeight(60),
                                child: SvgPicture.asset(
                                  'assets/svg/bufi.svg',
                                ),
                              ),
                            ),
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
                        height: ScreenUtil().setHeight(24),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${subsidiary.subsidiaryName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(22),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: colorBlueText,
                                  size: ScreenUtil().setWidth(16),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(11),
                                ),
                                Text(
                                  '${subsidiary.subsidiaryAddress}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'VER EN EL MAPA',
                              style: TextStyle(
                                color: colorBlueText,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(90),
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: colorPrimary,
                          elevation: 0,
                          bottom: ButtonsTabBar(
                              controller: tabcontroller,
                              unselectedBackgroundColor: colorPrimary,
                              duration: 250,
                              height: ScreenUtil().setHeight(50),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(4),
                              ),
                              unselectedLabelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                              decoration: BoxDecoration(
                                  color: colorPrimary,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: colorBlueImageBorder,
                                      width: 1.5,
                                    ),
                                  )),
                              labelStyle: TextStyle(
                                color: colorBlueImageBorder,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                              tabs: listTexto),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabcontroller,
                          children: pageList,
                        ),
                      ),
                    ],
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
                                      (subsidiary.subsidiaryFavourite == '1') ? 'assets/svg/heart_white.svg' : 'assets/svg/tabInicio/heart_w.svg'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'Cargar nuevamente',
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
        },
      ),
    );
  }
}
