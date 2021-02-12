part of 'widgets.dart';

class LeaderBoard extends StatefulWidget {
  final List<Dato> collection;
  final int deepLevel;

  LeaderBoard({@required this.collection, this.deepLevel = 3});

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int _totalVotes;
  List<Dato> _orderedCollection;

  @override
  void initState() {
    super.initState();
  }

  void _filterData() {
    _orderedCollection = [...widget.collection];
    _orderedCollection.sort((a, b) => b.intVotos.compareTo(a.intVotos));
    _totalVotes = this._orderedCollection.fold<int>(
          0,
          (int acc, Dato dato) => acc + dato.intVotos,
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    this._filterData();
    final hasData = widget.collection.length > 0;
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: hasData
            ? _buildLeaderBoardContent(context)
            : this._buildNotContent(context),
      ),
    );
  }

  List<Widget> _buildNotContent(BuildContext context) {
    return [
      Container(
        padding: EdgeInsets.only(top: 20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text('No hay datos que mostrar'),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildLeaderBoardContent(BuildContext context) {
    return [
      Container(
        padding: EdgeInsets.only(top: 20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.collection.length > 0 ? widget.deepLevel : 0,
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
          child: Text(
            'Top ${widget.deepLevel} de candidatos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  Widget _buildLeaderItem(BuildContext _, int positionIndex) {
    final candidate = _orderedCollection[positionIndex];

    final percent = (candidate.intVotos * 100 / _totalVotes).toStringAsFixed(2);

    return ListTile(
      leading: Text('${candidate.strNomCandidato}'),
      trailing: Text('$percent %'),
    );
  }
}
