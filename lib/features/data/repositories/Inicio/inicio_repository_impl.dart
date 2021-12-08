import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/features/data/datasources/Inicio/Publicidad/publicidad_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Inicio/Publicidad/publicidad_remote_datasource.dart';
import 'package:bufi_remake/features/data/models/Inicio/Publicidad/publicidad_model.dart';
import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';
import 'package:bufi_remake/features/domain/repositories/Inicio/inicio_repository.dart';
import 'package:dartz/dartz.dart';

class InicioRepositoryImpl implements InicioRepository {
  final PublicidadLocalDataSource? publicidadLocalDataSource;
  final PublicidadRemoteDataSource? publicidadRemoteDataSource;
  final NetworkInfo? networkInfo;

  InicioRepositoryImpl({
    required this.publicidadLocalDataSource,
    required this.publicidadRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PublicidadEntities>>> getPublicidad() async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListPublicidad = await publicidadRemoteDataSource!.getPublicidad();

        for (var i = 0; i < remoteListPublicidad.length; i++) {
          var data = remoteListPublicidad[i];

          PublicidadModel publi = PublicidadModel(
            idPublicidad: data.idPublicidad,
            idCity: data.idCity,
            idSubsidiary: data.idSubsidiary,
            publicidadImagen: data.publicidadImagen,
            publicidadOrden: data.publicidadOrden,
            publicidadDateTime: data.publicidadDateTime,
            publicidadEstado: data.publicidadEstado,
            idPago: data.idPago,
          );
          await publicidadLocalDataSource!.insertPublicidad(publi);
        }
        return Right(remoteListPublicidad);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListPublicidad = await publicidadLocalDataSource!.getPublicidad();
        return Right(localListPublicidad);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
