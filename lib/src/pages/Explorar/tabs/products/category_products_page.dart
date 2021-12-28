import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/ProductCategoryPage.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePageProductos>(context, listen: false);
    final categoryBloc = ProviderBloc.category(context);
    categoryBloc.obtenerCategories();
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: Text(
          'Productos',
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
        leading: MenuWidget(),
      ),
      body: StreamBuilder(
          stream: categoryBloc.categoryStream,
          builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                var datos = snapshot.data!;
                return ListView.builder(
                    itemCount: datos.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.changePageSubCategory(1, datos[index], context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(24),
                                vertical: ScreenUtil().setHeight(16),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${datos[index].categoryName}',
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
                return Text('Sin categorías');
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
