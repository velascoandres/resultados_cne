import 'package:meta/meta.dart';
import 'package:resultados_cne/models/result_response.dart';

List<Dato> filterReduceResultCollection({
  @required List<Dato> datos,
  @required int top,
}) {
  if (datos == null || datos.length == 0) {
    return [];
  }

  final List<Dato> orderedCollection = [...datos];
  orderedCollection.sort((a, b) => b.intVotos.compareTo(a.intVotos));

  List<Dato> topCollection = orderedCollection.sublist(0, top);
  List<Dato> restCollection = orderedCollection.sublist(top).toList();

  int restTotal =
      restCollection.fold(0, (acc, candidato) => acc + candidato.intVotos);

  final otros = Dato(intVotos: restTotal, strNomCandidato: ' RESTO');

  return [
    ...topCollection,
    otros,
  ];
}
