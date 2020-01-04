
import 'package:api/api.dart';

class UserController extends ResourceController {
  
  final ManagedContext context;
  final AuthServer authServer;

  UserController(this.context, this.authServer);

  @Operation.post()
  Future<Response> store(@Bind.body() User user) async {

    if(user.username == null || user.password == null) {
      return Response.badRequest(body: {"error": "Usuário ou senha invalido."});
    }

    user..salt = AuthUtility.generateRandomSalt();
    user..hashedPassword = authServer.hashPassword(user.password, user.salt);

    return Response.ok(await Query(context, values: user).insert());
  }

}