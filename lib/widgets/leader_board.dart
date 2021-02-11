part of 'widgets.dart';

class LeaderBoard extends StatelessWidget {
  final List<Dato> collection;
  final int deepLevel;
  int _totalVotes;

  LeaderBoard({@required this.collection, this.deepLevel = 3}) {
    this.collection.sort((a, b) => b.intVotos.compareTo(a.intVotos));
    _totalVotes = this.collection.fold<int>(
          0,
          (int acc, Dato dato) => acc + dato.intVotos,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return AspectRatio(
      aspectRatio: 2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListView.builder(
          itemCount: deepLevel,
          itemBuilder: _buildLeaderItem,
        ),
      ),
    );
  }

  Widget _buildLeaderItem(BuildContext _, int positionIndex) {
          final candidate = this.collection[positionIndex];
  
          final percent =  (candidate.intVotos * 100 / _totalVotes).toStringAsFixed(2);
  
          return ListTile(
            leading: Text('${candidate.strNomCandidato}'),
            trailing: Text('$percent %'),
          );
        }
}
