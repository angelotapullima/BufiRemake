
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/data/models/Explorar/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:dartz/dartz.dart';

abstract class ProXItemSubRepository {
  //remote
  Future<Either<Failure, List<ProductoModel>>> getProductosPorItemSubcategoriaPaginado(String ? idItemSubCat,String pagina);
  //local
  Future<Either<Failure, List<ProductoModel>>> getProductosPorItemSubcategoria(String ? idItemSubCat);
}
