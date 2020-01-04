
import 'package:api/api.dart';

class Servico extends ManagedObject<_Servico> implements _Servico {}

@Table(name: 'servicos')
class _Servico {
  
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column()
  String nome;

  @Column()
  String sigla;

  @Relate(#servicos)
  PontoAtendimento ponto_atendimento;

}
