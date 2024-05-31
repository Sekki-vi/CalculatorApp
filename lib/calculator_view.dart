import 'package:calculator_app/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  
  // Initialize required variables
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  // Method that conducts the calculator logic
  buttonPressed(String buttonText){
    
    setState(() {
      
      // Clears equation and result if "AC" is pressed
      if (buttonText == "AC") {
        equation = "0";
        result = "0";

      // Removes one digit if backspace is pressed; resets eqaution to 0 if last digit is removed.
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }

      // Sets expresion equal to the equation once "=" is pressed; converts the equation to be compatible with Expression method.
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('x', '*');

      // This is where the calculations are performed; Math_expressions package does the job here
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }

      // Writes the equation to be sent to expression, as a string.
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          const Icon(Icons.more_vert,
                              color: Colors.green, size: 30),
                          const SizedBox(width: 12),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(result,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize:80))),
                          const SizedBox(width: 20),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          Transform.scale(
                            scaleX: -1,
                          child: IconButton(
                            icon: const Icon(Icons.backspace_outlined,
                                color: Colors.green, 
                                size: 30,
                                ),
                            onPressed: () {
                              buttonPressed("⌫");
                            },
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(equation,
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white24,
                                )),
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('+', Colors.white10, () => buttonPressed('+')),
                  calcButton('-', Colors.white10, () => buttonPressed('-')),
                  calcButton('x', Colors.white10, () => buttonPressed('x')),
                  calcButton('/', Colors.white10, () => buttonPressed('/')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7', Colors.white24, () => buttonPressed('7')),
                  calcButton('8', Colors.white24, () => buttonPressed('8')),
                  calcButton('9', Colors.white24, () => buttonPressed('9')),
                  calcButton('AC', Colors.white10, () => buttonPressed('AC')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          calcButton(
                            '4', Colors.white24, () => buttonPressed('4')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                            '5', Colors.white24, () => buttonPressed('5')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                            '6', Colors.white24, () => buttonPressed('6')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          calcButton(
                              '1', Colors.white24, () => buttonPressed('1')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '2', Colors.white24, () => buttonPressed('2')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '3', Colors.white24, () => buttonPressed('3')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          calcButton(
                              '0', Colors.white24, () => buttonPressed('0')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '.', Colors.white24, () => buttonPressed('.')),
                        ],
                      ),
                    ],
                  ),
                  calcButton('=', Colors.green, () => buttonPressed('=')),
            ],
          ),
          const SizedBox(height: 10),
            ],
        ),
    )
    );
  }
  }