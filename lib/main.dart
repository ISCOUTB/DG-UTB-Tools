import 'package:flutter/material.dart';

void main() {
  runApp(MyWebApp());
}

class MyWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTB Tools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ButtonPage(),
        '/calculate-grade': (context) => CalculateGradePage(),
      },
    );
  }
}

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 17, 43, 1),
        title: Text(
          'UTB Tools',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // Icono de menú a la derecha
            onPressed: () {
              // Acción para el botón del menú
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[400],
            height: 1.0,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/utb_tools_logo.jpeg',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 20),
                  _buildButton('CONVERTIR ARCHIVOS', () {}),
                  SizedBox(height: 20),
                  _buildButton('CALCULA TU NOTA', () {
                    Navigator.pushNamed(context, '/calculate-grade');
                  }),
                  SizedBox(height: 20),
                  _buildButton('GENERAR HORARIO', () {}),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'UTB Tools© 2024',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 300,  // Aumenté el tamaño del botón
      height: 60,  // Aumenté el tamaño del botón
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(11, 123, 142, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,  // Aumenté el tamaño de la fuente
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CalculateGradePage extends StatefulWidget {
  @override
  _CalculateGradePageState createState() => _CalculateGradePageState();
}

class _CalculateGradePageState extends State<CalculateGradePage> {
  final TextEditingController corte1Controller = TextEditingController();
  final TextEditingController corte2Controller = TextEditingController();
  double notaFinalNecesaria = 0.0;
  String mensaje = '';

  void calcularNotaFinal() {
    double corte1 = double.tryParse(corte1Controller.text) ?? 0.0;
    double corte2 = double.tryParse(corte2Controller.text) ?? 0.0;
    double pesoCorte1 = 0.30;
    double pesoCorte2 = 0.35;
    double pesoCorte3 = 0.35;

    double notaRequerida = (3 - (corte1 * pesoCorte1 + corte2 * pesoCorte2)) / pesoCorte3;
    setState(() {
      notaFinalNecesaria = notaRequerida;

      if (notaFinalNecesaria < 0) {
        mensaje = 'Ya tu estas ganado, eres un crack';
      } else if (notaFinalNecesaria >= 0 && notaFinalNecesaria <= 2.9) {
        mensaje = 'Ya casi, no te rindas, tu puedes';
      } else if (notaFinalNecesaria >= 3 && notaFinalNecesaria <= 4.9) {
        mensaje = 'Te toca esforzarte más, pero tú puedes, ¡ánimo ánimo!';
      } else {
        mensaje = 'Ombe, ni con brujería ganas la materia JAJAJA';
      }
    });
  }

  void limpiarCampos() {
    setState(() {
      corte1Controller.clear();
      corte2Controller.clear();
      notaFinalNecesaria = 0.0;
      mensaje = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 17, 43, 1), // Fondo azul oscuro
        title: Text(
          'UTB Tools',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // Botón de menú de tres líneas
            onPressed: () {
              // Acción del botón de menú
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Línea fina
          child: Container(
            color: Colors.grey[400],
            height: 1.0,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Calcula tu nota',
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Primera nota', style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: corte1Controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Ingresa la primera nota',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Text('Segunda nota', style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: corte2Controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Ingresa la segunda nota',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: calcularNotaFinal,
                    child: Text('Calcular'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: limpiarCampos,
                    child: Text('Limpiar'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'NOTA MINIMA EN TERCER CORTE PARA APROBAR:',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                notaFinalNecesaria > 0
                    ? notaFinalNecesaria.toStringAsFixed(2)
                    : 'RESULTADO',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                mensaje,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Image.asset(
                'assets/images/utb_tools_logo.jpeg',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'UTB Tools© 2024',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}