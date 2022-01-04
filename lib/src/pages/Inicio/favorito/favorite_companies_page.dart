import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:bufi_remake/src/widgets/negocio_subsidiary_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';

class FavoriteCompaniesPage extends StatelessWidget {
  const FavoriteCompaniesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsFavoritosBloc = ProviderBloc.favoritos(context);
    productsFavoritosBloc.obtenerSubsidiaryFavorites();
    return StreamBuilder(
      stream: productsFavoritosBloc.subsidiariesFavoriteStream,
      builder: (context, AsyncSnapshot<List<SubsidiaryModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            var datos = snapshot.data!;
            return ListView.builder(
              itemCount: datos.length,
              itemBuilder: (_, index) {
                return NegocioSubsidiaryHorizontalWidget(
                  subsidiary: datos[index],
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Sin negocios favoritos',
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
