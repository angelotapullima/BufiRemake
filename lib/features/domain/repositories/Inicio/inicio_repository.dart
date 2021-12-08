import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';
import 'package:dartz/dartz.dart';

abstract class InicioRepository {
  Future<Either<Failure, List<PublicidadEntities>>> getPublicidad();
}
