import 'package:bagberg_shop/providers/auth_provider.dart';
import 'package:bagberg_shop/providers/location_provider.dart';
import 'package:bagberg_shop/screens/map_screen.dart';
import 'package:bagberg_shop/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome-screen';

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    bool _validPhoneNumber= false;
    var _phoneNumberController = TextEditingController();

    void showBottomSheet(context){
      showModalBottomSheet(
        context: context,
        builder: (context)=> StatefulBuilder(
          builder: (context, StateSetter myState){
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: auth.error=='Invalid OTP'? true:false,
                      child: Container(
                        child: Column(
                          children: [
                            Text(auth.error,style: TextStyle(color: Colors.red,fontSize: 12),),
                            SizedBox(height: 5,),
                          ],
                        ),
                      ),
                    ),
                    Text('LOGIN',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('Enter your phone number to proceed',
                      style: TextStyle(fontSize: 12,color: Colors.grey),),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixText: '+91',
                        labelText: 'Enter 10 digit mobile number',
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: _phoneNumberController,
                      onChanged: (value){
                        if(value.length==10){
                          myState((){
                            _validPhoneNumber = true;
                          });
                        }else{
                          myState((){
                            _validPhoneNumber = false;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children:[
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: _validPhoneNumber? false:true,
                            child:
                            ElevatedButton(
                              // color :_validPhoneNumber? Theme.of(context).primaryColor: Colors.grey,),
                              child: Text(_validPhoneNumber? 'CONTINUE':'ENTER YOUR PHONE NUMBER',style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                String number = '+91${_phoneNumberController.text}';
                                auth.verifyPhone(context, number).then((value){
                                  _phoneNumberController.clear();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    final locationData = Provider.of<LocationProvider>(context,listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              child: TextButton(
              child: Text('SKIP',style: TextStyle(color: Colors.blueAccent),),
              onPressed: (){},
            ),
            ),
            Column(
              children: [
                Expanded(child: OnBoardScreen(),),
                Text('Ready to order from your nearest shop ?',
                  style: TextStyle(color: Colors.grey),),
                SizedBox(height: 20,),

                ElevatedButton(
                  child: Text('SET YOUR LOCATION',
                    style: TextStyle(color: Colors.white ),),
                  onPressed: ()async{

                    await locationData.getCurrentPosition();
                    if(locationData.permissionAllowed==true){
                      Navigator.pushReplacementNamed(context, MapScreen.id);
                    }else{
                      print('permission not allowed');
                    }
                    },
                ),

                TextButton(
                  child: RichText(text: TextSpan(
                    text: 'Already a Customer ?',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: ' Login',
                        style: TextStyle(
                            fontWeight:FontWeight.bold,color:Colors.blueAccent),

                      ),
                    ],
                  ),
                  ),
                  onPressed: (){
                    showBottomSheet(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
