
import 'package:bufi_remake/src/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItems {
  static const card = MenuItem('Mi Bufi Card', 'assets/svg/tarjeta.svg');
  static const home = MenuItem('Inicio', 'assets/svg/home.svg');
  static const explore = MenuItem('Explorar', 'assets/svg/explorar.svg');
  static const mensaje = MenuItem('Mensajes', 'assets/svg/mensaje.svg');
  static const pedido = MenuItem('Pedidos', 'assets/svg/pedido.svg');
  static const vender = MenuItem('Vender', 'assets/svg/vender.svg');
  static const confi = MenuItem('Configuración', 'assets/svg/confi.svg');
  static const terminos = MenuItem('Términos y políticas', 'assets/svg/terminos.svg');
  static const logout = MenuItem('Cerrar Sesión', 'assets/svg/logout.svg');

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
    return Scaffold(
      backgroundColor: Color(0XFF17314C),
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
                Container(
                  height: ScreenUtil().setHeight(80),
                  width: ScreenUtil().setWidth(80),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(24),
                ),
                Text(
                  'Lincoln Tapullima',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.017,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(14),
                ),
                Text(
                  'lincolntapullima@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.017,
                  ),
                ),

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
                ...MenuItems.all.map(construirItem).toList(),
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

  Widget construirItem(MenuItem item) {
    return InkWell(
      onTap: () {
        onSelectItem!(item);
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