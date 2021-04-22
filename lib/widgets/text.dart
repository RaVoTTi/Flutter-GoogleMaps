part of 'widgets.dart';


class TextTitle extends StatelessWidget {
  final String text1;
  final String text2;
  
  const TextTitle({ @required this.text1,@required  this.text2});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
  
          this.text1,
          
          style: TextStyle(
            color: Color(0xff00939d),
            fontFamily: 'MontserratLight',
            fontSize: 35,
            letterSpacing: 7,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.none
          ),
          
        ),
        Text(
  
          this.text2,
          
          style: TextStyle(
            color: Color(0xff00939d),
            fontFamily: 'Montserrat',
            fontSize: 35,
            letterSpacing: 3,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none
          ),
          
        ),
      ],
    );
  }
}