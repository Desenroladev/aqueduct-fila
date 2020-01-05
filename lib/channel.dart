
import 'package:api/controller/operador_controller.dart';
import 'package:aqueduct/managed_auth.dart';

import 'api.dart';

class ApiChannel extends ApplicationChannel {

  ManagedContext context;

  AuthServer authServer;

  @override
  Future prepare() async {
    
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = MyConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final pg = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username, 
      config.database.password, 
      config.database.host, 
      config.database.port, 
      config.database.databaseName);

      context = ManagedContext(dataModel, pg);

    final authStorage = ManagedAuthDelegate<Usuario>(context);
    authServer = AuthServer(authStorage);

  }

  @override
  Controller get entryPoint {

    final router = Router();

    router
      .route("/auth/token")
      .link(() => AuthController(authServer));
      
    router
      .route("/pontos-atendimentos/[:id]")
      .link(() => Authorizer.bearer(authServer))
      .link(() => PontoAtendimentoController(context));

    router
      .route("/servicos/[:id]")
      .link(() => Authorizer.bearer(authServer))
      .link(() => ServicoController(context));

    router
      .route("/usuarios/[:id]")
      .link(() => Authorizer.bearer(authServer))
      .link(() => UsuarioController(context, authServer));

    router
      .route("/operadores/[:id]")
      .link(() => Authorizer.bearer(authServer))
      .link(() => OperadorController(context, authServer));

    return router;
  }
  
}

class MyConfig extends Configuration {

  MyConfig(String path) : super.fromFile(File(path)); 

  DatabaseConfiguration database;

}