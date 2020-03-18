import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers_api/models/data_repository.dart';

import 'bloc/trivia_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: BlocProvider(
          create: (context) => TriviaBloc(TriviaRepository()),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.amber,
      body: BlocListener<TriviaBloc, TriviaState>(
        listener: (context, state) {
          if (state is TriviaError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  state.errorMessage,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<TriviaBloc, TriviaState>(
          builder: (context, state) {
            if (state is TriviaInitial) {
              return buildInitialState();
            } else if (state is TriviaLoading) {
              return buildTriviaLoading();
            } else if (state is TriviaLoaded) {
              return buildTriviaLoaded(state.trivia);
            }
          },
        ),
      ),
    );
  }

  Align buildInitialState() {
    double height = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            buildTextField(),
            buildFlatButton('NUMBER TRIVIA'),
            SizedBox(height: 10),
            Text('OR',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                )),
            SizedBox(height: 10),
            buildFlatButton('RANDOM TRIVIA'),
          ],
        ),
      ),
    );
  }

  buildTriviaLoading() {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            height: height * 0.6,
            color: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  buildTextField(),
                  buildFlatButton('NUMBER TRIVIA'),
                  SizedBox(height: 10),
                  Text('OR',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      )),
                  SizedBox(height: 10),
                  buildFlatButton('RANDOM TRIVIA'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTriviaLoaded(String trivia) {
    List<String> num = trivia.split(' ');
    String number = num[0];
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: height * 0.6,
                // color: Colors.redAccent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        number,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        trivia,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Spacer(),
            Container(
              height: height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  buildTextField(),
                  buildFlatButton('NUMBER TRIVIA'),
                  SizedBox(height: 10),
                  Text('OR',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      )),
                  SizedBox(height: 10),
                  buildFlatButton('RANDOM TRIVIA'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Container(
        width: 200,
        child: TextField(
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
          ),
          controller: _controller,
          keyboardType: TextInputType.number,
          cursorColor: Colors.amberAccent,
          // cursorRadius: Radius.circular(5),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(
                color: Colors.amber,
                style: BorderStyle.solid,
              ),
            ),
            // filled: true,
            hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 20,
                fontFamily: 'Montserrat',
                textBaseline: TextBaseline.alphabetic),
            hintText: "ENTER A NUMBER",
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }

  FlatButton buildFlatButton(String text) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          )),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      onPressed: () {
        if (text == 'RANDOM TRIVIA') {
          BlocProvider.of<TriviaBloc>(context).add(RandomNumberTrivia());
        } else if (text == 'NUMBER TRIVIA') {
            try {
              BlocProvider.of<TriviaBloc>(context).add(
                NumberTrivia(int.parse(_controller.text)),
              );
            } on Exception {
                BlocProvider.of<TriviaBloc>(context).add(
                  EnteredFloat()
              );
            }
          
          _controller.text = '';
        }
      },
    );
  }
}
