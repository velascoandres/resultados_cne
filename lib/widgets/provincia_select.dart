part of 'widgets.dart';

class ProvinciaSelect extends StatelessWidget {
  final Function onSelected;

  const ProvinciaSelect({@required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final filtroBloc = context.read<FiltroBloc>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<int>(
        value: filtroBloc.state.numProvincia,
        onChanged: (int numProvincia) {
          filtroBloc.add(OnProvinciaChange(numProvincia));
        },
        icon: Icon(Icons.maps_ugc_outlined),
        items: [
          new DropdownMenuItem(
            value: -1,
            child: Text('TODOS'),
          ),
          ...this._buildPlacesList(),
        ],
      ),
    );
  }

  DropdownMenuItem<int> _buildItem(Place place) {
    return DropdownMenuItem<int>(
      value: place.code,
      child: Text('${place.name}'),
    );
  }

  List<DropdownMenuItem<int>> _buildPlacesList() {
    return PROVINCIAS.keys.map(
      (key) {
        final value = PROVINCIAS[key];
        final provinciaName = value['provincia'];
        final place = Place(code: int.parse(key), name: provinciaName);
        return this._buildItem(place);
      },
    ).toList();
  }
}
