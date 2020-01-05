
import 'package:api/api.dart';
import 'package:aqueduct/managed_auth.dart';

class Usuario extends ManagedObject<_User> implements _User, ManagedAuthResourceOwner<_User> {

  @Serialize(input: true, output: false)
  String password;

}

@Table(name: 'usuarios')
class _User extends ResourceOwnerTableDefinition {

  @Column()
  String nome;

  ManagedSet<Operador> operadores;
  ManagedSet<Senha> senhas;  
    
}
