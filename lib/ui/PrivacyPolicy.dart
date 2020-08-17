import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Privacy Policy'),
         backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Row(          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.86,
              width: MediaQuery.of(context).size.width*0.90,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                        child: Text("      Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16.0),
                    ),
                      ),
                    SizedBox(
                      height: 15.0,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
                      child: Text("      The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16.0),
                      ),
                    ),
                    ],)
                    
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}