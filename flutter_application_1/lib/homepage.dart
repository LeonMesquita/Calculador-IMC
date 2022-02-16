import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String resultado = 'Informe seus dados!';
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    resultado = 'Informe seus dados!';
    _formKey = GlobalKey<FormState>();
  }

  void obterResultado() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if (imc < 18.6) {
      resultado = 'Abaixo do peso (${imc.toStringAsPrecision(4)}kg)';
    } else if (imc >= 18.6 && imc < 24.9) {
      resultado = 'Peso ideal (${imc.toStringAsPrecision(4)}kg)';
    } else if (imc >= 24.9 && imc < 29.9) {
      resultado = 'Levemente acima do peso (${imc.toStringAsPrecision(4)}kg)';
    } else if (imc >= 29.0 && imc < 34.9) {
      resultado = 'Obesidade Grau I (${imc.toStringAsPrecision(4)}kg)';
    } else if (imc >= 34.9 && imc < 39.9) {
      resultado = 'Obesidade Grau II (${imc.toStringAsPrecision(4)}kg)';
    } else if (imc >= 40) {
      resultado = 'Obesidade Grau III (${imc.toStringAsPrecision(4)}kg)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Calculadora de IMC',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _resetFields();
              });
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.green,
                    cursorWidth: 0.5,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    textAlign: TextAlign.center,
                    controller: weightController,

                    // Parte de validação do TextFormField:
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.green,
                    cursorWidth: 0.5,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    textAlign: TextAlign.center,
                    controller: heightController,

                    // Parte de validação do TextFormField:
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          obterResultado();
                        }
                      });
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(double.infinity, 50)),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '$resultado',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
