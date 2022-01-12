import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:bufi_remake/src/pages/Negocio/Subsidiary/subsidiary_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubsidiariesPage extends StatelessWidget {
  const SubsidiariesPage({Key? key, required this.idCompany}) : super(key: key);
  final String idCompany;

  @override
  Widget build(BuildContext context) {
    final subsidiaryBloc = ProviderBloc.subsidiary(context);
    subsidiaryBloc.obtenerSubsidiariesByIdCompany(idCompany);
    return StreamBuilder(
        stream: subsidiaryBloc.subsidiariesStream,
        builder: (_, AsyncSnapshot<List<SubsidiaryModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var subsidiary = snapshot.data!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                child: GridView.builder(
                    itemCount: subsidiary.length,
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
                          child: SubsidiaryWidget(
                            subsidiary: subsidiary[index],
                          ),
                        );
                      });
                    }),
              );
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
        });
  }
}
