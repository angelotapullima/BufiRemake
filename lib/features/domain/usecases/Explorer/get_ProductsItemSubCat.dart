import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/data/models/Explorar/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/productosPorItemSubcategoria/proxItemSub_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsItemSubCategory implements UseCase<List<ProductoModel>, ItemSubcategoryParams> {
  final ProXItemSubRepository? proXItemSubRepository;

  GetProductsItemSubCategory({this.proXItemSubRepository});

  @override
  Future<Either<Failure, List<ProductoModel>>> call(ItemSubcategoryParams params) async {
    return await proXItemSubRepository!.getProductosPorItemSubcategoria(params.idSubCategory);
  }
}

class ItemSubcategoryParams {
  final String? idSubCategory;

  ItemSubcategoryParams({required this.idSubCategory});

  List<Object?> get props => [idSubCategory];
}
