import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';
import 'package:bufi_remake/features/domain/repositories/Inicio/inicio_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetPublicidad implements UseCase<List<PublicidadEntities>, PublicidadParams> {
  final InicioRepository? publicidadRepository;
  GetPublicidad({this.publicidadRepository});
  @override
  Future<Either<Failure, List<PublicidadEntities>>> call(PublicidadParams params) async {
    return await publicidadRepository!.getPublicidad();
  }
}

class PublicidadParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
