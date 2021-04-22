part of 'widgets.dart';

class Searcher extends StatelessWidget {
  final String placeHolder;
  final TextEditingController textController;
  final double width;



  const Searcher({
      Key key,
    
      @required this.placeHolder,
      @required this.textController, 
      @required this.width,
      
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 7, left: 30, right: 30),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
),
        child: TextField(
          controller: this.textController,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff00939d),
            fontSize: 20),
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            // focusedBorder: InputBorder.none,
            // border: InputBorder.none,
            hintText: this.placeHolder
          ),
        ));
  }

}
