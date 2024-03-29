import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'bufibd.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableCategoryleSql);
      db.execute(tableItemSubCategorySql);
      db.execute(tableSubCategorySql);
      db.execute(tableProductoSql);
      db.execute(tablePublicidadSql);
      db.execute(tablePantallaPrincipalSql);
      db.execute(tableProductosPantallaPrincipalSql);
      db.execute(tableCompanySql);
      db.execute(tableSubsidiarySql);
      db.execute(tableCarritoSql);
      db.execute(tableBienesSql);
      db.execute(tableServiciosSql);
      //db.execute(VehiclesLocalDataSourceImpl.tableSql); */
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }

  static const String tableCategoryleSql = 'CREATE TABLE Category('
      'idCategory TEXT PRIMARY KEY, '
      'categoryName TEXT, '
      'categoryEstado TEXT,'
      'categoryImage TEXT)';

  static const String tableSubCategorySql = 'CREATE TABLE SubCategory('
      'idSubCategory TEXT PRIMARY KEY, '
      'nameSubCategory TEXT, '
      'idCategory TEXT)';

  static const String tableItemSubCategorySql = 'CREATE TABLE ItemSubCategory('
      'idItemSubCategory TEXT PRIMARY KEY, '
      'nameItemSubCategory TEXT, '
      'estadoItemSubCategory TEXT,'
      'imagenItemSubCategory TEXT,'
      'idSubCategory TEXT)';

  static const String tableProductoSql = 'CREATE TABLE Producto('
      'idProducto VARCHAR  PRIMARY KEY,'
      'idSubsidiary VARCHAR,'
      'idGood VARCHAR,'
      'idItemsubcategory VARCHAR,'
      'productoName VARCHAR,'
      'productoPrice VARCHAR,'
      'productoCurrency VARCHAR,'
      'productoImage VARCHAR,'
      'productoCharacteristics VARCHAR,'
      'productoBrand VARCHAR,'
      'productoModel VARCHAR,'
      'productoType VARCHAR,'
      'productoSize VARCHAR,'
      'productoStock VARCHAR,'
      'productoMeasure VARCHAR,'
      'productoRating VARCHAR,'
      'productoUpdated VARCHAR,'
      'productoStatus VARCHAR,'
      'productoFavourite VARCHAR)';

  static const String tablePublicidadSql = 'CREATE TABLE Publicidad('
      'idPublicidad TEXT PRIMARY KEY, '
      'idCity TEXT, '
      'idSubsidiary TEXT,'
      'publicidadImagen TEXT,'
      'publicidadOrden TEXT,'
      'publicidadDateTime TEXT,'
      'publicidadEstado TEXT,'
      'idPago TEXT)';

  static const String tablePantallaPrincipalSql = 'CREATE TABLE PantallaPrincipal('
      'idPantalla VARCHAR PRIMARY KEY,'
      'nombre VARCHAR,'
      'tipo VARCHAR'
      ')';

  static const String tableProductosPantallaPrincipalSql = 'CREATE TABLE ProductosPantallaPrincipal('
      'idProducto VARCHAR PRIMARY KEY,'
      'idPantalla VARCHAR'
      ')';

  static const String tableCompanySql = 'CREATE TABLE Company('
      'idCompany VARCHAR PRIMARY KEY,'
      'idUser VARCHAR,'
      'idCity VARCHAR,'
      'idCategory VARCHAR,'
      'companyName VARCHAR,'
      'companyRuc VARCHAR,'
      'companyImage VARCHAR,'
      'companyType VARCHAR,'
      'companyShortcode VARCHAR,'
      'companyDeliveryPropio VARCHAR,'
      'companyDelivery VARCHAR,'
      'companyEntrega VARCHAR,'
      'companyTarjeta VARCHAR,'
      'companyVerified VARCHAR,'
      'companyRating VARCHAR,'
      'companyCreatedAt VARCHAR,'
      'companyJoin VARCHAR,'
      'companyStatus VARCHAR,'
      'miNegocio VARCHAR'
      ')';
  static const String tableSubsidiarySql = 'CREATE TABLE Subsidiary('
      'idSubsidiary VARCHAR PRIMARY KEY,'
      'idCompany VARCHAR,'
      'subsidiaryName VARCHAR,'
      'subsidiaryDescription VARCHAR,'
      'subsidiaryAddress VARCHAR,'
      'subsidiaryImg VARCHAR,'
      'subsidiaryCellphone VARCHAR,'
      'subsidiaryCellphone2 VARCHAR,'
      'subsidiaryEmail VARCHAR,'
      'subsidiaryCoordX VARCHAR,'
      'subsidiaryCoordY VARCHAR,'
      'subsidiaryOpeningHours VARCHAR,'
      'subsidiaryPrincipal VARCHAR,'
      'subsidiaryStatus VARCHAR,'
      'subsidiaryFavourite VARCHAR'
      ')';

  static const String tableCarritoSql = 'CREATE TABLE Carrito('
      'idCarrito INTEGER PRIMARY KEY AUTOINCREMENT,'
      'idSubsidiarygood VARCHAR ,'
      'idSubsidiary VARCHAR,'
      'nombre VARCHAR,'
      'precio VARCHAR,'
      'marca VARCHAR,'
      'modelo VARCHAR,'
      'talla VARCHAR,'
      'image VARCHAR,'
      'moneda VARCHAR,'
      'caracteristicas VARCHAR,'
      'stock VARCHAR,'
      'cantidad VARCHAR,'
      'estadoSeleccionado VARCHAR'
      ')';

  static const String tableBienesSql = 'CREATE TABLE Bienes('
      'idGood VARCHAR PRIMARY KEY,'
      'goodName VARCHAR ,'
      'goodSynonyms VARCHAR'
      ')';
  static const String tableServiciosSql = 'CREATE TABLE Servicios('
      'idServicio VARCHAR PRIMARY KEY,'
      'idSubsidiary VARCHAR,'
      'idService VARCHAR,'
      'idItemsubcategory VARCHAR,'
      'servicioName VARCHAR,'
      'servicioDescription VARCHAR,'
      'servicioPrice VARCHAR,'
      'servicioCurrency VARCHAR,'
      'servicioImage VARCHAR,'
      'servicioRating VARCHAR,'
      'servicioUpdated VARCHAR,'
      'servicioStatus VARCHAR,'
      'servicioFavourite VARCHAR'
      ')';
}
