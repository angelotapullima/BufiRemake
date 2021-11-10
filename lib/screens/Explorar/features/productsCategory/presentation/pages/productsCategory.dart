import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/widgets/connection_error.dart';
import 'package:bufi_remake/core/widgets/progress.dart';
import 'package:bufi_remake/core/widgets/unknown_error.dart';
import 'package:bufi_remake/injection_container.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/presentation/bloc/productscategory_bloc.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text('Productos'),
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body: BlocProvider(
        create: (_) => sl<ProductscategoryBloc>()..add(GetCategoriesBlocEvent()),
        child: Center(
          child: BlocBuilder<ProductscategoryBloc, ProductscategoryState>(
            builder: (context, state) {
              if (state is Empty) {
                return SizedBox(
                  height:50,
                  child: Text('vacio'),
                );
              } else if (state is Loading) {
                return Progress();
              } else if (state is Loaded) {
                return _listCategories(state.listCategories);
              } else if (state is Error) {
                return ConnectionError();
              } else {
                return UnknownError();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _listCategories(List<CategoriesEntities> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  height: ScreenUtil().setHeight(29),
                  child: Row(
                    children: [
                      Text('${list[index].categoryName}'),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      )
                    ],
                  ),
                ),
                Divider()
              ],
            ),
          );
        });
  }
}
