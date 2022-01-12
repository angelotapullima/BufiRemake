import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformacionCompany extends StatelessWidget {
  const InformacionCompany({Key? key, required this.idCompany}) : super(key: key);
  final String idCompany;

  @override
  Widget build(BuildContext context) {
    final companyBloc = ProviderBloc.company(context);
    companyBloc.obtenerNegocioById(idCompany);
    return StreamBuilder(
        stream: companyBloc.companyIdStream,
        builder: (_, AsyncSnapshot<List<CompanyModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var company = snapshot.data![0];
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(8)),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(26), vertical: ScreenUtil().setHeight(16)),
                    decoration: BoxDecoration(
                      color: colorSecond,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (company.sucursalPrincipal!.subsidiaryDescription != 'null')
                            ? Text(
                                '${company.sucursalPrincipal!.subsidiaryDescription}',
                                style: TextStyle(
                                  color: colorIcon,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Text(
                          'Horario de atención:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        Text(
                          '${company.sucursalPrincipal!.subsidiaryOpeningHours}',
                          style: TextStyle(
                            color: colorIcon,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        (company.companyTarjeta == '1')
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.credit_card,
                                    color: colorBlueText,
                                    size: ScreenUtil().setWidth(16),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(11),
                                  ),
                                  Text(
                                    'Acepta pago por tarjeta',
                                    style: TextStyle(
                                      color: colorIcon,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: (company.companyTarjeta == '1') ? ScreenUtil().setHeight(8) : 0,
                        ),
                        (company.companyDeliveryPropio == '1')
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: colorBlueText,
                                    size: ScreenUtil().setWidth(16),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(11),
                                  ),
                                  Text(
                                    'Delivery propio',
                                    style: TextStyle(
                                      color: colorIcon,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: (company.companyDeliveryPropio == '1') ? ScreenUtil().setHeight(8) : 0,
                        ),
                        (company.companyDelivery == '1')
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining_rounded,
                                    color: colorBlueText,
                                    size: ScreenUtil().setWidth(16),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(11),
                                  ),
                                  Text(
                                    'Delivery terceros',
                                    style: TextStyle(
                                      color: colorIcon,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'Cargar nuevamente',
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
