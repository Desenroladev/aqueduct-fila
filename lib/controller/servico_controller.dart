
import 'package:api/api.dart';

class ServicoController extends ResourceController {
  
  ManagedContext context;

  ServicoController(this.context);

  @Operation.get()
  Future<Response> getAll() async {

    final query = Query<Servico>(context);
    final servicos = await query.fetch();

    return Response.ok(servicos);
  }

  @Operation.get('id')
  Future<Response> getOne(@Bind.path('id') int id) async {

    final query = Query<Servico>(context)
                    ..join(object: (o) => o.ponto_atendimento)
                    ..where((s) => s.id)
                    .equalTo(id);
                      
    final servico = await query.fetchOne();

    if(servico == null) {
      return Response.notFound();
    }

    return Response.ok(servico);
  }

  @Operation.post()
  Future<Response> store(@Bind.body(ignore: ['id']) Servico servico) async {

    final query = Query<Servico>(context)
                    ..values = servico;
    final insert = await query.insert();

    return Response.ok(insert);
  }

  @Operation.put('id')
  Future<Response> put(@Bind.path('id') int id, @Bind.body() Servico servico) async {

    final query = Query<Servico>(context)
                  ..where((q) => q.id)
                  .equalTo(id)
                  ..values = servico;
                  
    final update = await query.updateOne();

    return Response.ok(update);
  }

  @Operation.delete('id')
  Future<Response> delete(@Bind.path('id') int id) async {
    
    final query = Query<Servico>(context)..where((q) => q.id).equalTo(id);
    final ponto = await query.delete();

    if(ponto == 0) {
      return Response.notFound();
    }

    return Response.ok(ponto);
  }

}