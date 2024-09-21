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
        backgroundColor: Color.fromRGBO(11, 17, 43, 1), // Color de fondo del AppBar
        title: Text(
          'UTB Tools',
          style: TextStyle(
            color: Colors.white, // Color del texto del título
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
            color: Colors.grey[400], // Línea gris debajo del AppBar
            height: 1.0,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(11, 17, 43, 1), // Fondo oscuro original
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Minimiza el espacio ocupado por la columna
                children: [
                  // Implementación del Logo con tamaño ajustado
                  Image.asset(
                    'assets/images/utb_tools_logo.jpeg', // Asegúrate de que la extensión coincida
                    width: 300, // Tamaño del logo
                    height: 300, // Tamaño del logo
                  ),
                  SizedBox(height: 20), // Menos espacio entre el logo y los botones
                  _buildButton('CONVERTIR ARCHIVOS', () {}),
                  SizedBox(height: 15),
                  _buildButton('CALCULA TU NOTA', () {
                    Navigator.pushNamed(context, '/calculate-grade');
                  }),
                  SizedBox(height: 15),
                  _buildButton('GENERAR HORARIO', () {}),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter, // Alinea el texto en la parte inferior
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
      width: 280,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(11, 123, 142, 1), // Azul verdoso original de los botones
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Texto blanco
            fontSize: 16,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 123, 142, 1), // Azul verdoso original
        elevation: 0,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Volver al Menú',
            style: TextStyle(
              color: Colors.white, // Texto blanco
              fontSize: 16,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(11, 17, 43, 1), // Fondo oscuro original
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: corte1Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nota del Corte 1 (0-5)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: corte2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nota del Corte 2 (0-5)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(11, 123, 142, 1), // Azul verdoso original
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: calcularNotaFinal,
                child: Text('Calcular Nota Final Necesaria'),
              ),
              SizedBox(height: 20),
              Text(
                'Nota necesaria en el corte final para aprobar: ${notaFinalNecesaria.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                mensaje,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
