import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'My Card',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  // void-returns nothing, async-runs in background without freezing app UI works --function itslf may pause at some point, await-pause at certain point unless it completes- Fututre lets use await with function call while void alone doesnot let use wait with function call
  Future<void> _dialNumber(String url) async
  {
    final Uri uri=Uri.parse("tel:$url");
    if(!await launchUrl(uri, mode: LaunchMode.externalApplication))
      {
        throw Exception("Could not launch $url");
      }
  }

Future<void> _openUrl(String url) async
{
  final Uri uri=Uri.parse(url);

  if(!await launchUrl(uri,
  mode: LaunchMode.externalApplication)){
    throw Exception("COuld not lauch $url");
  }
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff0f172a),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius:70,
                backgroundImage:AssetImage("assets/images/bugs-bunny.jpg") ,
              ),
        SizedBox(height: 20),
              Text(
                "Hiba Saud",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Flutter Developer".toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.shade200,
                  letterSpacing: 3,
                )
              ),
        SizedBox(
          width:140,
            height: 30,
            child: Divider(color: Colors.white24)),


              // Phone Card
              Card(
               child: ListTile(
                 leading: Icon(Icons.phone,
                 ),
                 title: Text("+92 315 4956758"),
                 trailing: IconButton(
                   icon: Icon(Icons.copy),
                   onPressed: (){
Clipboard.setData(
  ClipboardData(text: "+92 315 4956758")); //--copies number to clipboard

ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Container(
        child: Text("Number copied!")),
      duration: Duration(seconds:1),
      behavior: SnackBarBehavior.floating,
    )
);
                   },
                 ),
                 onTap: () async{
                   await _dialNumber("+923154956758");
                 },
               )
              ),

              // Email Card
              Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Tooltip(
                    message: "hibasaud18@gmail.com",
                    child: Text("hibasaud18@gmail.com",
                    maxLines:1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    ),
                  ),
                  trailing:IconButton(
                      onPressed:(){
                        _openUrl("mailto:hibasaud18@gmail.com");//no await-doesnot wait at this point to wait for e function to complete and wait for it eiter runs successfully or shows exception while we do what we are supposed to do after call and if error shows it is visible later --does not await here at this point to make sure this runs or not
                      },
                      icon: Icon(Icons.open_in_new)),
                ),
              ),

              // Insta Card
              Card(
                child: ListTile(
                  leading:Icon(Icons.camera_alt,
                  color: Colors.pink
                  ) ,
                  title: Text("Instagram",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  ),
                  trailing: IconButton(onPressed: (){
                    _openUrl("https://www.instagram.com/hib_a1402");
                  },
                      icon: Icon(Icons.open_in_new)),
                )
              ),
Card(
  child: ListTile(
    leading: Icon(Icons.facebook,
    color: Colors.blue
    ),
    title: Text("Facebook"),
    trailing: IconButton(onPressed: (){
      _openUrl("https://facebook.com");
    }, icon: Icon(Icons.open_in_new)),
  ),
),
              
              Card(
                child: ListTile(
                  leading: Icon(Icons.work),
                  title: Text("LinkedIn"),
                  trailing: IconButton(onPressed: (){
                    _openUrl("https://www.linkedin.com/in/hiba-saud");
                  },
                      icon: Icon(Icons.open_in_new)),
                ),
              )

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.share),
          onPressed: (){
Share.share(

  "Contact me on Instagram: https://www.instagram.com/hib_a1402\nFacebook: https://facebook.com\nLinkedIn: https://www.linkedin.com/in/hiba-saud\nPhone: +92 315 4956758",
  subject: "My Flutter App",
);

          }
      ),
    );
  }
}