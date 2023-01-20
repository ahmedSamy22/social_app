
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icons_broken.dart';

Widget defaultButton({
  required Function() function,
  Color background = Colors.blue,
  required double width,
  required String text,
}) {
  return (Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: background,
    ),
    width: width,
    height: 40.0,
    child: MaterialButton(
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      onPressed: function,
    ),
  ));
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardTybe,
  bool isPassword = false,
  IconData? prefixIcon,
  required String label,
  required String? Function(dynamic value) validator,
  Function()? onTap,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? suffixPressed,
  IconData? suffix,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardTybe,
    obscureText: isPassword,
    validator: validator,
    onTap: onTap,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: label,
      border: OutlineInputBorder(),
      suffixIcon: suffix != null
          ? IconButton(
        icon: Icon(suffix),
        onPressed: suffixPressed,
      )
          : null,
    ),
  );
}


Widget listDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child:   Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


void navigateTo(context, widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);


void navigateAndFinish(context, widget)=> Navigator.pushAndRemoveUntil(
  context,

  MaterialPageRoute(
    builder: (context) => widget,
  ),
  (route) => false,
);

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,WARNING,ERROR}

Color choseColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
  }

  return color;

}

PreferredSizeWidget? defaultAppBar(
{
  required BuildContext context,
  List<Widget>? actions,
  String? title,
}) =>AppBar(
  title: Text(title!,),
  titleSpacing: 5.0,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  actions: actions,
);