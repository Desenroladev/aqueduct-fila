
import 'package:api/controller/ponto_atendimento_controller.dart';
import 'package:api/controller/servico_controller.dart';

import 'api.dart';

class ApiChannel extends ApplicationChannel {

  ManagedContext context;

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

  }

  @override
  Controller get entryPoint {

    final router = Router();

    router
      .route("/pontos-atendimentos/[:id]")
      .link(() => PontoAtendimentoController(context));

    router
      .route("/servicos/[:id]")
      .link(() => ServicoController(context));

    return router;
  }
}

class MyConfig extends Configuration {

  MyConfig(String path) : super.fromFile(File(path)); 

  DatabaseConfiguration database;

}