
import 'package:api/api.dart';

@Table(name: 'senhas')
class _Senha {

  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column()
  String numero;

  @Relate(#senhas)
  User usuario;

}

class Senha extends ManagedObject<_Senha> implements _Senha {
  
}