import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/widgets/producto_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductosSubsidiaryPage extends StatelessWidget {
  const ProductosSubsidiaryPage({Key? key, required this.idSubsidiary}) : super(key: key);
  final String idSubsidiary;

  @override
  Widget build(BuildContext context) {
    final productosBloc = ProviderBloc.producto(context);
    productosBloc.obtenerProductosByIdSucursal(idSubsidiary);

    return StreamBuilder(
      stream: productosBloc.productosBySubsidiaryStream,
      builder: (_, AsyncSnapshot<List<ProductoModel>> snapshot) {
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
                'Sin sucursales para este negocio',
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
    );
  }
}
