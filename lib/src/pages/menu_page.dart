import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/models/menu_items.dart';
import 'package:bufi_remake/src/pages/logout_page.dart';
import 'package:bufi_remake/src/widgets/info_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItems {
  static const card = MenuItem('Mi Bufi Card', 'assets/svg/tarjeta.svg', 1);
  static const home = MenuItem('Inicio', 'assets/svg/home.svg', 2);
  static const explore = MenuItem('Explorar', 'assets/svg/explorar.svg', 3);
  static const mensaje = MenuItem('Mensajes', 'assets/svg/mensaje.svg', 4);
  static const pedido = MenuItem('Pedidos', 'assets/svg/pedido.svg', 5);
  static const vender = MenuItem('Vender', 'assets/svg/vender.svg', 6);
  static const confi = MenuItem('Configuración', 'assets/svg/confi.svg', 7);
  static const terminos = MenuItem('Términos y políticas', 'assets/svg/terminos.svg', 8);
  static const logout = MenuItem('Cerrar Sesión', 'assets/svg/logout.svg', 9);

  static const all = <MenuItem>[
    card,
    home,
    explore,
    mensaje,
    pedido,
    vender,
    confi,
    terminos,
    logout,
  ];
}

class MenuPage extends StatelessWidget {
  final MenuItem? itemSeleccionado;
  final ValueChanged<MenuItem>? onSelectItem;
  const MenuPage({Key? key, @required this.itemSeleccionado, @required this.onSelectItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = MenuItems.all
        .map(
          (item) => construirItem(item, context),
        )
        .toList();

    return Scaffold(
      backgroundColor: colorPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                InfoUser(),
                SizedBox(
                  height: ScreenUtil().setHeight(22),
                ),
                Container(
                  height: ScreenUtil().setHeight(1),
                  width: ScreenUtil().setWidth(200),
                  color: Colors.white,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Column(
                  children: widgets,
                )

                //...MenuItems.all.map(construirItem).toList(),
                // Spacer(
                //   flex: 2,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget construirItem(MenuItem item, BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.orden == 9) {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) {
                return LogoutPage();
              },
              // transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //   var begin = Offset(0.0, 1.0);
              //   var end = Offset.zero;
              //   var curve = Curves.ease;

              //   var tween = Tween(begin: begin, end: end).chain(
              //     CurveTween(curve: curve),
              //   );

              //   return SlideTransition(
              //     position: animation.drive(tween),
              //     child: child,
              //   );
              // },
            ),
          );
        } else {
          print(item.orden);
          onSelectItem!(item);
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          //top: ScreenUtil().setHeight(5),
          bottom: ScreenUtil().setHeight(5),
          // right: ScreenUtil().setWidth(50),
        ),
        //margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(10)),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15), horizontal: ScreenUtil().setWidth(19)),
        decoration: BoxDecoration(
          color: (itemSeleccionado == item) ? Color(0XFF152535) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              child: SvgPicture.asset(item.icon),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(19),
            ),
            Text(
              item.titulo,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
