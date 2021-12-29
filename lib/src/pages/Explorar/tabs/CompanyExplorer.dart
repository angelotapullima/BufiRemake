import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompanyExplorer extends StatelessWidget {
  const CompanyExplorer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companyBloc = ProviderBloc.company(context);
    companyBloc.listarCompanies();
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: Text(
          'Negocios',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
          ),
        ),
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
      ),
      body: StreamBuilder(
          stream: companyBloc.companyStream,
          builder: (_, AsyncSnapshot<List<CompanyModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                var datos = snapshot.data!;
                return ListView.builder(
                    itemCount: datos.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(24),
                                vertical: ScreenUtil().setHeight(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: ScreenUtil().setWidth(60),
                                    height: ScreenUtil().setHeight(60),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => Container(
                                          width: ScreenUtil().setWidth(60),
                                          height: ScreenUtil().setHeight(60),
                                          child: SvgPicture.asset(
                                            'assets/svg/bufi.svg',
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          child: Container(
                                            width: ScreenUtil().setWidth(60),
                                            height: ScreenUtil().setHeight(60),
                                            child: SvgPicture.asset(
                                              'assets/svg/bufi.svg',
                                            ),
                                          ),
                                        ),
                                        imageUrl: '$API_BASE_URL/${datos[index].companyImage}',
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: colorBlueImageBorder, width: ScreenUtil().setWidth(1.5)),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(24),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${datos[index].companyName}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: colorIcon,
                                    size: ScreenUtil().setSp(18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0XFFA1A1A1),
                            thickness: 0.4,
                          ),
                        ],
                      );
                    });
              } else {
                return Center(
                  child: Text("No hay negocios"),
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
