part of 'widgets.dart';

class ProvinciaSelect extends StatelessWidget {
  const ProvinciaSelect();

  @override
  Widget build(BuildContext context) {
    final filtroBloc = context.read<FiltroBloc>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<int>(
            underline: SizedBox(),
            value: filtroBloc.state.numProvincia,
            onChanged: (int numProvincia) {
              filtroBloc.add(OnProvinciaChange(numProvincia));
            },
            icon: Icon(Icons.arrow_drop_down),
            hint: Text('Selecciona una provincia'),
            isExpanded: true,
            items: [
              new DropdownMenuItem(
                value: -1,
                child: Text('Todas las provincias'),
              ),
              ...this._buildPlacesList(),
            ],
          ),
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
