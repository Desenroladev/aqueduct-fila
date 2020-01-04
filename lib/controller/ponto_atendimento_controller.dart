
import 'package:api/api.dart';

class PontoAtendimentoController extends ResourceController {
  
  PontoAtendimentoController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {

    final query = Query<PontoAtendimento>(context);
    final pontos = await query.fetch();

    return Response.ok(pontos);
  }

  @Operation.get('id')
  Future<Response> getOne(@Bind.path('id') int id) async {

    final query = Query<PontoAtendimento>(context)..where((q) => q.id).equalTo(id);
    final ponto = await query.fetchOne();

    if(ponto == null) {
      return Response.notFound();
    }

    return Response.ok(ponto);
  }

  @Operation.put('id')
  Future<Response> put(@Bind.path('id') int id, @Bind.body() PontoAtendimento ponto) async {

    final query = Query<PontoAtendimento>(context)
                  ..where((q) => q.id)
                  .equalTo(id)
                  ..values = ponto;
                  
    final update = await query.updateOne();

    return Response.ok(update);
  }

  @Operation.post()
  Future<Response> store(@Bind.body(ignore: ['id']) PontoAtendimento ponto) async {

    final query = Query<PontoAtendimento>(context)..values = ponto;
    final store = await query.insert();

    return Response.ok(store);
  }

  @Operation.delete('id')
  Future<Response> delete(@Bind.path('id') int id) async {
    
    final query = Query<PontoAtendimento>(context)..where((q) => q.id).equalTo(id);
    final ponto = await query.delete();

    if(ponto == 0) {
      return Response.notFound();
    }

    return Response.ok(ponto);
  }

}