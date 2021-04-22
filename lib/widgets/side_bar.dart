part of 'widgets.dart';

class SideBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
              child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, int i) { 
                      if (i ==0) { 
                        return DrawerHeader(child: TextTitle(text1: 'CUYO', text2: 'BUS'));
                        
                        }
                      
                      return ListTile(title: Text('Opcion $i'));
                      },
    ),
      )
    );
}}