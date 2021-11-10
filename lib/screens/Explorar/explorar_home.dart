import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/presentation/pages/productsCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'features/Company/presentation/pages/companyExplorer.dart';
import 'features/ServicesCategory/presentation/pages/servicesCategory.dart';

class ExplorarHome extends StatefulWidget {
  const ExplorarHome({Key? key}) : super(key: key);

  @override
  _ExplorarHomeState createState() => _ExplorarHomeState();
}

class _ExplorarHomeState extends State<ExplorarHome> {
  final _cargando = ChangeBottomExplorer();
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(ProductCategoryPage());
    pageList.add(ServicesCategoryPage());
    pageList.add(CompanyExplorer());
    //pageList.add(UserPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _cargando,
        builder: (_, data) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(10),
                ),
                child: IndexedStack(
                  index: _cargando.page,
                  children: pageList,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                    right: ScreenUtil().setWidth(30),
                    bottom: ScreenUtil().setHeight(10),
                  ),
                  height: kBottomNavigationBarHeight + ScreenUtil().setHeight(10),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _cargando.changePage(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(35),
                              width: ScreenUtil().setSp(35),
                              child: (_cargando.page == 0)
                                  ? SvgPicture.asset(
                                      'assets/svg/tabExplorer/box_product_b.svg',
                                    )
                                  : SvgPicture.asset(
                                      'assets/svg/tabExplorer/box_product_w.svg',
                                    ), //Imagsset('assets/logo_largo.svg'),
                            ),
                             
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _cargando.changePage(1);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(35),
                              width: ScreenUtil().setSp(35),
                              child: (_cargando.page == 1)
                                  ? SvgPicture.asset(
                                      'assets/svg/tabExplorer/tool_services_b.svg',
                                    )
                                  : SvgPicture.asset(
                                      'assets/svg/tabExplorer/tool_services_w.svg',
                                    ), //Imagsset('assets/logo_largo.svg'),
                            ),
                             
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _cargando.changePage(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(35),
                              width: ScreenUtil().setSp(35),
                              child: (_cargando.page == 2)
                                  ? SvgPicture.asset(
                                      'assets/svg/tabExplorer/company_b.svg',
                                    )
                                  : SvgPicture.asset(
                                      'assets/svg/tabExplorer/company_w.svg',
                                    ), //Imagsset('assets/logo_largo.svg'),
                            ),
                             
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChangeBottomExplorer extends ChangeNotifier {
  int page = 0;

  void changePage(int index) {
    page = index;
    notifyListeners();
  }
}
