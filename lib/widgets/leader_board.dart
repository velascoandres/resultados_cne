part of 'widgets.dart';

class LeaderBoard extends StatelessWidget {
  final List<Dato> collection;
  final int deepLevel;

  int _totalVotes;
  List<Dato> _orderedCollection;

  LeaderBoard({@required this.collection, this.deepLevel = 3}) {
    _orderedCollection = [...this.collection];
    _orderedCollection.sort((a, b) => b.intVotos.compareTo(a.intVotos));
    _totalVotes = this._orderedCollection.fold<int>(
          0,
          (int acc, Dato dato) => acc + dato.intVotos,
        );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListView.builder(
              itemCount: deepLevel,
              itemBuilder: _buildLeaderItem,
            ),
          ),
        ),
        Positioned(
          top: 1,
          left: MediaQuery.of(context).size.width / 3,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Top $deepLevel de candidatos', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
      ]),
    );
  }

  Widget _buildLeaderItem(BuildContext _, int positionIndex) {
    final candidate = this._orderedCollection[positionIndex];

    final percent = (candidate.intVotos * 100 / _totalVotes).toStringAsFixed(2);

    return ListTile(
      leading: Text('${candidate.strNomCandidato}'),
      trailing: Text('$percent %'),
    );
  }
}
