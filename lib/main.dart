import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/core/util/router.dart';
import 'package:bufi_remake/features/presentation/Explorar/explorar_home.dart';
import 'package:bufi_remake/src/models/menu_items.dart';
import 'package:bufi_remake/src/pages/home_page.dart';
import 'package:bufi_remake/src/pages/menu_page.dart';
import 'package:bufi_remake/src/pages/tarjeta_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di; //Dependency injector

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); //Inject all the dependencies and wait for it is done (i.e. UI won't built until all the dependencies are injected)
  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ChangeBottomExplorer>(
            create: (_) => ChangeBottomExplorer(),
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
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

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
        return HomePage();
      case MenuItems.explore:
        return ExplorarHome();
      default:
        return HomePage();
    }
  }
}
