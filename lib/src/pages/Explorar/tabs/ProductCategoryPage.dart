import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/products/category_products_page.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/products/item_sub_category_page.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/products/sub_category_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(CategoryProductsPage());
    pageList.add(SubCategoryProductsPage());
    pageList.add(ItemSubCategoryProductsPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePageProductos>(context, listen: false);
    return ValueListenableBuilder<int>(
      valueListenable: provider._pagina,
      builder: (_, value, __) {
        return Container(
          child: IndexedStack(
            index: value,
            children: pageList,
          ),
        );
      },
    );
  }
}

class ChangePageProductos extends ChangeNotifier {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> get _pagina => this.page;
  ValueNotifier<String> title = ValueNotifier('');
  ValueNotifier<String> get titulo => this.title;
  ValueNotifier<String> title2 = ValueNotifier('');
  ValueNotifier<String> get titulo2 => this.title2;

  void changePage(int index) {
    print('index $index');
    page.value = index;
    notifyListeners();
  }

  void changePageSubCategory(int index, CategoryModel category, BuildContext context) {
    print('index $index');
    page.value = index;

    title.value = category.categoryName.toString();

    final cateogryBloc = ProviderBloc.category(context);
    cateogryBloc.obtenerSubcatgories(category.idCategory.toString());
    notifyListeners();
  }

  void changePageItemSubCategory(int index, SubCategoryModel subcategory, BuildContext context) {
    print('index $index');
    page.value = index;

    title2.value = subcategory.nameSubCategory.toString();

    final cateogryBloc = ProviderBloc.category(context);
    cateogryBloc.obtenerItemsubcategories(subcategory.idSubCategory.toString());
    notifyListeners();
  }
}
