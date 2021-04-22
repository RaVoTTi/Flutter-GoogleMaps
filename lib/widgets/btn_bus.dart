part of 'widgets.dart';

class BtnBus extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context); 
    final myUbicationBloc = BlocProvider.of<MyUbicationBloc>(context); 
    
    
    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Color(0xff00939d),
        maxRadius: 30,
        child: IconButton(
          onPressed: () {  
            mapBloc.moveCamera(myUbicationBloc.state.ubication);
          }, 
          icon: Icon(Icons.directions_bus, color: Colors.white, size: 30,),

        ),
      )
    );
  }
}