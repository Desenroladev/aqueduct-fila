
import 'package:api/api.dart';

class UsuarioController extends ResourceController {
  
  final ManagedContext context;
  final AuthServer authServer;

  UsuarioController(this.context, this.authServer);

  @Operation.post()
  Future<Response> store(@Bind.body() Usuario user) async {

    if(user.nome == null) {
      return Response.badRequest(body: {"error":"O nome é obrigatório."});
    }
    if(user.username == null || user.password == null) {
      return Response.badRequest(body: {"error": "Usuário ou senha invalido."});
    }

    user..salt = AuthUtility.generateRandomSalt();
    user..hashedPassword = authServer.hashPassword(user.password, user.salt);

    return Response.ok(await Query(context, values: user).insert());
  }

}