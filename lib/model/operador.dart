
import 'package:api/api.dart';

@Table(name: 'operadores')
class _Operador {
  
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column()
  String nome;

  @Column()
  DateTime dataAdmissao;

  @Relate(#operadores)
  User usuario;

}

class Operador extends ManagedObject<_Operador> implements _Operador {
  
}