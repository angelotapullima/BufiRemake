import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformacionSubsidiaryPage extends StatelessWidget {
  const InformacionSubsidiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subsidiaryBloc = ProviderBloc.subsidiary(context);
    return StreamBuilder(
        stream: subsidiaryBloc.subsidiaryIdStream,
        builder: (_, AsyncSnapshot<List<SubsidiaryModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var subsidiary = snapshot.data![0];
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
                        (subsidiary.subsidiaryDescription != 'null' && subsidiary.subsidiaryDescription != '')
                            ? Text(
                                '${subsidiary.subsidiaryDescription}',
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
                          '${subsidiary.subsidiaryOpeningHours}',
                          style: TextStyle(
                            color: colorIcon,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: colorBlueText,
                              size: ScreenUtil().setWidth(16),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(11),
                            ),
                            (subsidiary.subsidiaryCellphone != '' && subsidiary.subsidiaryCellphone != 'null')
                                ? Text(
                                    '${subsidiary.subsidiaryCellphone} - ',
                                    style: TextStyle(
                                      color: colorIcon,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Container(),
                            // SizedBox(
                            //   width: ScreenUtil().setWidth(8),
                            // ),
                            (subsidiary.subsidiaryCellphone2 != '' && subsidiary.subsidiaryCellphone2 != 'null')
                                ? Text(
                                    '${subsidiary.subsidiaryCellphone2}',
                                    style: TextStyle(
                                      color: colorIcon,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: colorBlueText,
                              size: ScreenUtil().setWidth(16),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(11),
                            ),
                            (subsidiary.subsidiaryEmail != '' && subsidiary.subsidiaryEmail != 'null')
                                ? Text(
                                    '${subsidiary.subsidiaryEmail}',
                                    style: TextStyle(
                                      color: colorIcon,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
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
