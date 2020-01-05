
import 'package:api/api.dart';

class OperadorController extends ResourceController {
  
  ManagedContext context;
  AuthServer authServer;

  OperadorController(this.context, this.authServer);
  
  @Operation.get()
  Future<Response> index() async {
    final query = Query<Operador>(context)..join(object: (o) => o.usuario);
    return Response.ok(await query.fetch());
  }

  @Operation.post()
  Future<Response> store() async {

    final Map<String, dynamic> body = await request.body.decode();

    final usuario = Usuario();
    usuario..nome = body['nome'] as String;
    usuario..password = body['password'] as String;
    usuario..username = body['username'] as String;
    usuario..salt = AuthUtility.generateRandomSalt();
    usuario..hashedPassword = authServer.hashPassword(usuario.password, usuario.salt);

    final insert = await Query(context, values: usuario).insert();


    final operador = Operador();
    operador.nome = body['nome'] as String;
    operador.dataAdmissao = DateTime.parse(body['dataAdmissao'] as String);
    operador.usuario = insert;

    final newOperador = await Query(context, values: operador).insert();

    return Response.ok(newOperador);
  }

}