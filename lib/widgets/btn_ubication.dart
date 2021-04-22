part of 'widgets.dart';

class BtnUbication extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context); 
    final myUbicationBloc = BlocProvider.of<MyUbicationBloc>(context); 
    
    
    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 30,
        child: IconButton(
          onPressed: () {  
            mapBloc.moveCamera(myUbicationBloc.state.ubication);
          }, 
          icon: Icon(Icons.my_location, color: Color(0xff00939d),),

        ),
      )
    );
  }
}