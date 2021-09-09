import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LayoutBuilder(builder: (_, constrains) {
        return Container(
          //color: Colors.red,
          //height: 400,
          child: Stack(
            children: <Widget>[
              Positioned(
                  //top: 200,
                  top: constrains.maxHeight * 0.7,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 3,
                        width: constrains.maxWidth,
                        color: const Color(0xffeeeeee),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Bienvenidos a PaqueteExpress",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Positioned(
                  top: constrains.maxHeight * 0.15,
                  left: -50,
                  child: SvgPicture.asset(
                    "imagenes/repartidor.png",
                    width: constrains.maxWidth,
                    height: constrains.maxHeight * 0.7,
                  ))
              /*  Positioned(
                  top: constrains.maxHeight * 0.09,
                  right: 5,
                  child: SvgPicture.asset(
                    "imagenes/repartidor.svg",
                    width: constrains.maxWidth,
                    height: constrains.maxHeight * 0.7,
                  )) */
            ],
          ),
        );
      }),
    );
  }
}
