import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/servicios/category_services_page.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/servicios/item_sub_category_page.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/servicios/services_page.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/servicios/sub_category_services_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesCategoryPage extends StatefulWidget {
  const ServicesCategoryPage({Key? key}) : super(key: key);

  @override
  State<ServicesCategoryPage> createState() => _ServicesCategoryPageState();
}

class _ServicesCategoryPageState extends State<ServicesCategoryPage> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(CategoryServicesPage());
    pageList.add(SubCategoryServicesPage());
    pageList.add(ItemSubCategoryServicesPage());
    pageList.add(ServiciosPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePageServices>(context, listen: false);
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

class ChangePageServices extends ChangeNotifier {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> get _pagina => this.page;
  ValueNotifier<String> title = ValueNotifier('');
  ValueNotifier<String> get titulo => this.title;
  ValueNotifier<String> title2 = ValueNotifier('');
  ValueNotifier<String> get titulo2 => this.title2;
  ValueNotifier<String> title3 = ValueNotifier('');
  ValueNotifier<String> get titulo3 => this.title3;

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
    cateogryBloc.obtenerSubcatgoriesServices(category.idCategory.toString());
    notifyListeners();
  }

  void changePageItemSubCategory(int index, SubCategoryModel subcategory, BuildContext context) {
    print('index $index');
    page.value = index;

    title2.value = subcategory.nameSubCategory.toString();

    final cateogryBloc = ProviderBloc.category(context);
    cateogryBloc.obtenerItemsubcategoriesService(subcategory.idSubCategory.toString());
    notifyListeners();
  }

  void changePageServices(int index, ItemSubCategoryModel itemsubcategory, BuildContext context) {
    print('index $index');
    page.value = index;

    title3.value = itemsubcategory.nameItemSubCategory.toString();

    final servicesBloc = ProviderBloc.servicios(context);
    servicesBloc.obtenerServiciosPorIdItemSubcategory(itemsubcategory.idItemSubCategory.toString());
    notifyListeners();
  }
}
