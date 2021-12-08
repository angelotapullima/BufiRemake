
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/data/models/Explorer/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:dartz/dartz.dart';

abstract class ProXItemSubRepository {
  Future<Either<Failure, List<ProductoModel>>> getProductosPorItemSubcategoria(String ? idItemSubCat);
}
