import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/widgets/producto_horizontal_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';

class FavoriteProductsPage extends StatelessWidget {
  const FavoriteProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsFavoritosBloc = ProviderBloc.favoritos(context);
    productsFavoritosBloc.obtenerProductosFavoritos();
    return StreamBuilder(
      stream: productsFavoritosBloc.productosFavoriteStream,
      builder: (context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            var datos = snapshot.data!;
            return ListView.builder(
              itemCount: datos.length,
              itemBuilder: (_, index) {
                return ProductoHorizontalWidget(
                  producto: datos[index],
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Sin productos favoritos',
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
