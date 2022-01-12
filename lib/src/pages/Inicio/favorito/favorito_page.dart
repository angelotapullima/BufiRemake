import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/pages/Inicio/favorito/favorite_companies_page.dart';
import 'package:bufi_remake/src/pages/Inicio/favorito/favorite_products_page.dart';
import 'package:bufi_remake/src/pages/Inicio/favorito/favorite_services_page.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<Widget> pageList = [];
  final List<Widget> listTexto = [];

  @override
  void initState() {
    pageList.add(FavoriteProductsPage());
    pageList.add(FavoriteServicesPage());
    pageList.add(FavoriteCompaniesPage());
    listTexto.add(Tab(text: 'Productos'));
    listTexto.add(Tab(text: 'Servicios'));
    listTexto.add(Tab(text: 'Negocios'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: DefaultTabController(
        initialIndex: 0,
        length: pageList.length,
        child: SafeArea(
            child: Column(
          children: [
            Container(
              height: ScreenUtil().setHeight(100),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: colorPrimary,
                title: Text(
                  'Mis favoritos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w600,
                  ),
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
                bottom: ButtonsTabBar(
                    unselectedBackgroundColor: colorPrimary,
                    duration: 250,
                    height: ScreenUtil().setHeight(50),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
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
                children: pageList,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
