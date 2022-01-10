import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:bufi_remake/src/widgets/servicios_horizontal_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';

class FavoriteServicesPage extends StatelessWidget {
  const FavoriteServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviciosFavoriteBloc = ProviderBloc.favoritos(context);
    serviciosFavoriteBloc.obtenerServiciosFavorites();
    return StreamBuilder(
        stream: serviciosFavoriteBloc.serviciosFavoriteStream,
        builder: (_, AsyncSnapshot<List<ServicioModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var datos = snapshot.data!;
              return ListView.builder(
                itemCount: datos.length,
                itemBuilder: (_, index) {
                  return ServiciosHorizontalWidget(
                    servicio: datos[index],
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
        });
  }
}
