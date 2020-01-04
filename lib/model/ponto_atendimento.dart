
import 'package:api/api.dart';

@Table(name: "pontos_atendimento")
class _PontoAtendimento {
  
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column()
  String nome;
  
  ManagedSet<Servico> servicos;

}

class PontoAtendimento extends ManagedObject<_PontoAtendimento> implements _PontoAtendimento {}