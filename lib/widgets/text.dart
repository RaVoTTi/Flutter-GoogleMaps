part of 'widgets.dart';


class TextTitle extends StatelessWidget {
  final String text;
  final bool bold;
  const TextTitle({ @required this.text, this.bold = false});
  
  @override
  Widget build(BuildContext context) {
    return Text(
  
      this.text,
      
      style: TextStyle(
        color: Color(0xff00939d),
        fontFamily: this.bold ?  'Montserrat':'MontserratLight',
        fontSize: 30,
        letterSpacing: 3,
        fontWeight: this.bold ?  FontWeight.w900:FontWeight.w300,
        decoration: TextDecoration.none
      ),
      
    );
  }
}