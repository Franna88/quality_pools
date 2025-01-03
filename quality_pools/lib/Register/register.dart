import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/poolImage.dart';




class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
              Color(0xFF002A6A),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'QUALITY-POOLS-',
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 50,
                height: 1.5, // Adjust spacing between lines if needed
              ),
            ),
           Form(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
                TextFormField(
                 
                  decoration: const InputDecoration(
                    hintText: 'Please write a name',
                  ),
                
                ),
                const SizedBox(height: 30.0),]
           )),
           Form(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Please write a username',
                  ),
                
                ),
                const SizedBox(height: 30.0),]
           )),
           Form(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                TextFormField(
                 
                  decoration: const InputDecoration(
                    hintText: 'Please write a username',
                  ),
                
                ),
                const SizedBox(height: 30.0),]
           )),
           Form(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                TextFormField(
                 
                  decoration: const InputDecoration(
                    hintText: 'Please write a username',
                  ),
                
                ),
                const SizedBox(height: 30.0),]
           )),
           Form(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                TextFormField(
                 
                  decoration: const InputDecoration(
                    hintText: 'Please write a username',
                  ),
                
                ),
                const SizedBox(height: 30.0),]
           )),
             SizedBox(height: 20), // Add spacing between text and buttons
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0XFF1A8CF0),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {
                     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPoolImage(),
              ),);
                  },
                  child: const Text('Continue'),
                ),
          
            
            
          ],
        ),
      ),
    );
  }
}
