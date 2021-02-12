part of 'widgets.dart';

class CantonSelect extends StatelessWidget {

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
            value: filtroBloc.state.codCanton,
            onChanged: (int codCanton) {
              filtroBloc.add(OnCantonChange(codCanton));
            },
            icon: Icon(Icons.arrow_drop_down),
            hint: Text('Selecciona un canton'),
            isExpanded: true,
            items: [
              new DropdownMenuItem(
                value: -1,
                child: Text('Todos los cantones'),
              ),
              ...this._buildPlacesList(filtroBloc.state.numProvincia),
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

  List<DropdownMenuItem<int>> _buildPlacesList(int numProvincia) {
    final provincia = PROVINCIAS[numProvincia.toString()]; 
    final Map cantonesMap = provincia['cantones'];
    return cantonesMap.keys.map(
      (key) {
        final value = cantonesMap[key];
        final cantonName = value['canton'];
        final place = Place(code: int.parse(key), name: cantonName);
        return this._buildItem(place);
      },
    ).toList();
  }
}
