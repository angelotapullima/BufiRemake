import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/ProductCategoryPage.dart';
import 'package:bufi_remake/src/widgets/producto_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProductosPage extends StatelessWidget {
  const ProductosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePageProductos>(context, listen: false);
    final productosBloc = ProviderBloc.producto(context);
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
            productosBloc.cleanProductos();
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
          stream: productosBloc.productosItemSubcategoryStream,
          builder: (context, AsyncSnapshot<List<ProductoModel>> snapshot) {
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
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(4)),
                          child: ProductoWidget(
                            producto: datos[index],
                          ),
                        );
                      });
                    });
              } else {
                return Center(
                  child: Text(
                    'Sin productos',
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
