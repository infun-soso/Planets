import 'package:flutter/material.dart';
import 'package:planets/ui/home/DetailPage.dart';
import 'package:planets/model/planets.dart';
import 'package:planets/ui/home/text_style.dart';

  

class PlanetSummary extends StatelessWidget {
  final Planet planet;
  final bool horizontal;

  PlanetSummary(this.planet, {this.horizontal = true});

  PlanetSummary.vertical(this.planet): horizontal = false; // 继承PlanetSummary方便外部调用？

  @override
  Widget build(BuildContext context) {
   
    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
    );

    Widget _planetValue({ String value, String image }) {
      return new Row(
        children: <Widget>[
          new Image.asset(image, height: 12.0,),
          new Container(width: 8.0),
          new Text(value, style: regularTextStyle),
        ],
      );
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 10.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(planet.name, style: Style.titleTextStyle),
          new Container(height: 10.0),
          new Text(planet.location, style: Style.commonTextStyle),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                flex: horizontal ? 1 : 0,
                child: _planetValue(
                  value: planet.distance,
                  image: 'assets/img/ic_distance.png')

              ),
              new Container(
                width: horizontal ? 8.0 : 32.0,
              ),
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _planetValue(
                  value: planet.gravity,
                  image: 'assets/img/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    );

    final planetThumbnail = new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: 'planet-hero-${planet.id}',
        child: new Image(
          image: new AssetImage(planet.image),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? new EdgeInsets.only(left: 46.0)
        : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new GestureDetector(
      onTap: horizontal
        ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(planet),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                new FadeTransition(opacity: animation, child: child),
            ) ,
          )
        : null,
      child: new Container(
        // margin: const EdgeInsets.only(
        //   top: 16.0,
        //   bottom: 16.0,
        //   left: 24.0,
        //   right: 24.0
        // ),
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      ),
    );
  }
}

// EdgeInsets.only(left, top, right, bottom)：允许我们定义每边不同的边距。它们都是可选的，因此您只能指定例如left和top。
// EdgeInsets.fromLTRB(left, top, right, bottom)：与先前类似，但是必须使用位置参数指定四个边距。LTRB是一个记忆规则（左，上，右，下）。
// EdgeInsets.all(value)：为所有四个边设置相同的边距。
// EdgeInsets.symmetric(vertical, horizontal)：允许我们使用单个值指定顶部/底部和/或左侧/右侧。