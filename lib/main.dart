import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/core/util/router.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/pages/Explorar/explorar_home.dart';
import 'package:bufi_remake/src/models/menu_items.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/ProductCategoryPage.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/ServicesCategoryPage.dart';
import 'package:bufi_remake/src/pages/Inicio/inicio_home.dart';
import 'package:bufi_remake/src/pages/menu_page.dart';
import 'package:bufi_remake/src/pages/tarjeta_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ChangeBottomInicio>(
            create: (_) => ChangeBottomInicio(),
          ),
          ChangeNotifierProvider<ChangeBottomExplorer>(
            create: (_) => ChangeBottomExplorer(),
          ),
          ChangeNotifierProvider<ChangePageProductos>(
            create: (_) => ChangePageProductos(),
          ),
          ChangeNotifierProvider<ChangePageServices>(
            create: (_) => ChangePageServices(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bufi',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: Routers.generateRoute,
            initialRoute: SPLASH_ROUTE,
          ),
        ),
      ),
    );
  }
}
/* // */

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MenuItem itemSeleccionado = MenuItems.card;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 60,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      showShadow: true,
      style: DrawerStyle.Style1,
      backgroundColor: Colors.blueAccent,
      menuScreen: Builder(
        builder: (context) => MenuPage(
          itemSeleccionado: itemSeleccionado,
          onSelectItem: (item) {
            setState(
              () {
                itemSeleccionado = item;
                ZoomDrawer.of(context)!.close();
              },
            );
          },
        ),
      ),
      mainScreen: obtenerPage(),
    );
  }

  Widget obtenerPage() {
    switch (itemSeleccionado) {
      case MenuItems.card:
        return TarjetaPage();
      case MenuItems.home:
        return InicioPage();
      case MenuItems.explore:
        return ExplorarHome();
      default:
        return InicioPage();
    }
  }
}
