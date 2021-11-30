import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/presentation/pages/productsCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'features/Company/presentation/pages/companyExplorer.dart';
import 'features/ServicesCategory/presentation/pages/servicesCategory.dart';

class ExplorarHome extends StatefulWidget {
  const ExplorarHome({Key? key}) : super(key: key);

  @override
  _ExplorarHomeState createState() => _ExplorarHomeState();
}

class _ExplorarHomeState extends State<ExplorarHome> {
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
    final provider = Provider.of<ChangeBottomExplorer>(context, listen: false);
    return Scaffold(
      backgroundColor: colorPrimary,
      body: ValueListenableBuilder<int>(
        valueListenable: provider._pagina,
        builder: (_, value, __) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(10),
                ),
                child: IndexedStack(
                  index: value,
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
                        color: Colors.transparent.withOpacity(0.5),
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
                          provider.changePage(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(35),
                              width: ScreenUtil().setSp(35),
                              child: (value == 0)
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
                          provider.changePage(1);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(35),
                              width: ScreenUtil().setSp(35),
                              child: (value == 1 )
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
                          provider.changePage(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(35),
                              width: ScreenUtil().setSp(35),
                              child: (value == 2)
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
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> get _pagina => this.page;

  void changePage(int index) {
    print('index $index');
    page.value = index;
    notifyListeners();
  }
}
