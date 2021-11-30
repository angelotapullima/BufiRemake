import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/core/widgets/connection_error.dart';
import 'package:bufi_remake/core/widgets/progress.dart';
import 'package:bufi_remake/core/widgets/unknown_error.dart';
import 'package:bufi_remake/injection_container.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/models/subCategoriesModel.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/presentation/bloc/Categories/categories_bloc.dart';
import 'package:bufi_remake/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: BlocProvider(
        create: (_) => sl<CategoriesBloc>()..add(GetCategoriesBlocEvent()),
        child: Center(
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is Empty) {
                return SizedBox(
                  height: 50,
                  child: Text('vacio'),
                );
              } else if (state is Loading) {
                return Progress();
              } else if (state is ListaCategorias) {
                return Column(
                  children: [
                    AppBar(
                      backgroundColor: colorPrimary,
                      title: Text('Categorías'),
                      elevation: 0,
                      centerTitle: true,
                      leading: MenuWidget(),
                    ),
                    Expanded(child: _listCategories(state.listCategories)),
                  ],
                );
              } else if (state is ListaSubCategorias) {
                return Column(
                  children: [
                    AppBar(
                      backgroundColor: colorPrimary,
                      title: Text('${state.nombreCategoria}'),
                      elevation: 0,
                      centerTitle: true,
                      leading: BackButton(
                        onPressed: () {
                          BlocProvider.of<CategoriesBloc>(context).add(
                            GetCategoriesBlocEvent(),
                          );
                        },
                      ),
                    ),
                    Expanded(child: _listSubCategories(state.listSubCategories)),
                  ],
                );
              } else if (state is ListaItemSubCategorias) {
                return Column(
                  children: [
                    AppBar(
                      backgroundColor: colorPrimary,
                      title: Text('${state.nombreSubCategoria}'),
                      elevation: 0,
                      centerTitle: true,
                      leading: BackButton(
                        onPressed: () {
                          print(state.idCategory);
                          BlocProvider.of<CategoriesBloc>(context).add(
                            GetSubCategoriesBlocEvent( state.idCategory,state.nombreSubCategoria),
                          );
                        },
                      ),
                    ),
                    Expanded(child: _listItemSubCategories(state.listItemSubCategories)),
                  ],
                );
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
        return InkWell(
          onTap: () {
            BlocProvider.of<CategoriesBloc>(context).add(
              GetSubCategoriesBlocEvent(
                '${list[index].idCategory}',
                '${list[index].categoryName}',
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(6)),
            color: colorPrimary,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${list[index].categoryName}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Divider(thickness: .5, color: Colors.white)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listSubCategories(List<SubCategoriesModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            BlocProvider.of<CategoriesBloc>(context).add(
              GetItemSubCategoriesBlocEvent(
                '${list[index].idCategory}',
                '${list[index].subCategoryName}',
                '${list[index].idSubCategory}',
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(6)),
            color: colorPrimary,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${list[index].subCategoryName}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Divider(thickness: .5, color: Colors.white)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listItemSubCategories(List<ItemSubCategoriesModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(6)),
          color: colorPrimary,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${list[index].nameItemSubCategory}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Divider(thickness: .5, color: Colors.white)
            ],
          ),
        );
      },
    );
  }
}
