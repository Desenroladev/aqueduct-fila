
import 'package:api/api.dart';

@Table(name: 'chamadas')
class _Chamada {

  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column()
  bool status;

  @Column()
  DateTime dataChamado;

}

class Chamada extends ManagedObject<_Chamada> implements _Chamada { }