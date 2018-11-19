import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }

}

class HomeState extends State<home> {
  @override
  //String temperature;
  Widget build(BuildContext context) {
//    void getdata() async
//    {
//    Map data=await getResponse("Delhi");
//    setState(() {
//       double temp=data['list'][0]['main']['temp']-273.ceil();
//       temperature=temp.toStringAsFixed(2);
//    });
//    }
    return(new Scaffold(
      appBar: new AppBar(
        title: Text("Weather Kinematics",style:new TextStyle(
          fontSize: 18.0,
        )
        ),
      backgroundColor: Colors.orangeAccent,
      actions: <Widget>[
        new IconButton(icon: new Icon(Icons.menu), onPressed: ()=>futurewidget("Chennai"))
      ],
      ),
      body: new Stack(
        children: <Widget>[
          new Image.asset("/Users/ashukumar/IdeaProjects/weather/images/background.jpg",
          width: 700.0,
            height:800.0,
            fit: BoxFit.fitHeight,
          ),
          new Container
            (alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0.0, 15.0, 30.0, 0.0),
            child:new Text("City",
              style: new TextStyle(

                  fontSize: 30.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
              )
              )
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset("/Users/ashukumar/IdeaProjects/weather/images/light_rain.png",
            height: 300.0,width:400.0,)
          ),
          new Container
            (//alignment: Alignment.bottomLeft,
              margin: EdgeInsets.fromLTRB(50.0, 450.0, 00.0, 0.0),
              child:futurewidget("Chennai")
          ),
        ],
      )
    ));
  }
}

Future<Map> getResponse(String city) async
{
  String apiUrl="https://api.openweathermap.org/data/2.5/forecast?q=$city,IN&appid=8a412833abadabe8814e53d470cd43e6";
http.Response response= await http.get(apiUrl);
return jsonDecode(response.body);
}

Widget futurewidget (String city)
{
  return new FutureBuilder(future: getResponse(city),builder: (BuildContext context,AsyncSnapshot<Map> snapshot)
  {
  if(snapshot.hasData)
    {
      Map data=snapshot.data;
      double temp=data['list'][0]['main']['temp']-273.ceil();
      String temperature=temp.toStringAsFixed(2);
      return new Container(
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text("$temperature C*",style: new TextStyle(

                fontSize: 48.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              )),
            )
          ],
        )
      );
    }
  }
  );
}
