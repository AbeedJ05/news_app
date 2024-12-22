import 'package:flutter/material.dart';
import 'package:hotel_app/components/__form_content.dart';
import 'package:hotel_app/components/__logo.dart';



class SignInPage extends StatelessWidget {
  const SignInPage({super.key, required this.toggleButtons});
  final void Function() toggleButtons;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      
      body: Center(
        child: isSmallScreen
            ?   SingleChildScrollView(
              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Logo(),
                     const SizedBox(height: 16),
                     FormContent(toggleButton: toggleButtons,),
                     const SizedBox(height: 16),
           
                  ],
                ),
            )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: isPortrait
                    ?  SingleChildScrollView(
                      child:   Column(
                          children: [
                             const Logo(),
                              FormContent(toggleButton: toggleButtons,),
                             const SizedBox(height: 16),
                          
                            
                          ],
                        ),
                    )
                    :  Row(
                        children:  [
                           const Expanded(child:  Logo()),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               FormContent(toggleButton: toggleButtons,),
                                 const SizedBox(height: 16),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }

 
}

