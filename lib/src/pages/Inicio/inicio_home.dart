/* import 'package:bufi_remake/core/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatefulWidget {
  InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(HomePage());
    pageList.add(FavoritosPage());
    pageList.add(CarritoPage());
    pageList.add(NotificacionesPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangeBottomInicio>(context, listen: false);
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
                              height: ScreenUtil().setHeight(24),
                              width: ScreenUtil().setWidth(24),
                              child: (value == 0)
                                  ? SvgPicture.asset('assets/svg/tabInicio/home_b.svg')
                                  : SvgPicture.asset('assets/svg/tabInicio/home_w.svg'),
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
                              height: ScreenUtil().setHeight(24),
                              width: ScreenUtil().setWidth(24),
                              child: (value == 1)
                                  ? SvgPicture.asset('assets/svg/tabInicio/heart_b.svg')
                                  : SvgPicture.asset('assets/svg/tabInicio/heart_w.svg'),
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
                              height: ScreenUtil().setHeight(24),
                              width: ScreenUtil().setWidth(24),
                              child: (value == 2)
                                  ? SvgPicture.asset('assets/svg/tabInicio/shoping_car_b.svg')
                                  : SvgPicture.asset('assets/svg/tabInicio/shoping_car_w.svg'),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.changePage(3);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(24),
                              width: ScreenUtil().setWidth(24),
                              child: (value == 3)
                                  ? SvgPicture.asset('assets/svg/tabInicio/bell_b.svg')
                                  : SvgPicture.asset('assets/svg/tabInicio/bell_w.svg'),
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

class ChangeBottomInicio extends ChangeNotifier {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> get _pagina => this.page;

  void changePage(int index) {
    print('index $index');
    page.value = index;
    notifyListeners();
  }
}
 */