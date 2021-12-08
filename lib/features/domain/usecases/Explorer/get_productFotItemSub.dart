import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/data/models/Explorer/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/productosPorItemSubcategoria/proxItemSub_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductForItemSubCat implements UseCase<List<ProductoModel>, ProductForItemSubCatParams> {
  final ProXItemSubRepository? proXItemSubRepository;

  GetProductForItemSubCat({this.proXItemSubRepository});

  @override
  Future<Either<Failure, List<ProductoModel>>> call(ProductForItemSubCatParams params) async {
    return await proXItemSubRepository!.getProductosPorItemSubcategoria(params.idItemSubCategory);
  }
}

class ProductForItemSubCatParams {
  final String? idItemSubCategory;

  ProductForItemSubCatParams({required this.idItemSubCategory});

  List<Object?> get props => [idItemSubCategory];
}
