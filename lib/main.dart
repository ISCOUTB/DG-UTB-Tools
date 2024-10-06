import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;  // Para manejo de archivos en web
import 'dart:typed_data';  // Para manejar bytes de archivos





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
        '/convert-files': (context) => FileConverterPage(),  // Ruta para la página de conversión
      },
    );
  }
}


class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(11, 17, 43, 1),
        title: const Text(
          'UTB Tools',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Acción para el botón del menú
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
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
                  const SizedBox(height: 20),
                  _buildButton('CONVERTIR ARCHIVOS', () {
                    Navigator.pushNamed(context, '/convert-files');  // Navegación hacia la página de conversión
                  }),
                  const SizedBox(height: 20),
                  _buildButton('CALCULA TU NOTA', () {
                    Navigator.pushNamed(context, '/calculate-grade');
                  }),
                  const SizedBox(height: 20),
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
      width: 300,
      height: 60,
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
            fontSize: 18,
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

    double notaRequerida = (3 - (corte1 * pesoCorte1 + corte2 * pesoCorte2)) /
        pesoCorte3;
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
        backgroundColor: Color.fromRGBO(11, 17, 43, 1),
        // Fondo azul oscuro
        title: Text(
          'UTB Tools',
          style: TextStyle(color: Colors.white),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context); // Acción para volver al menú principal
          },
          child: Text(
            '⭠',
            style: const TextStyle(
              color: Colors.white, // Texto en blanco
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            // Botón de menú de tres líneas
            onPressed: () {
              // Acción del botón de menú
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Línea fina debajo del AppBar
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
                style: TextStyle(fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Primera nota',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: corte1Controller,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9.]')), // Permite solo números y el punto
                          ],
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
                      Text('Segunda nota',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: corte2Controller,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9.]')), // Permite solo números y el punto
                          ],
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
                      backgroundColor: Color(0xFF0B7B8E), // Color azul del logo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: calcularNotaFinal,
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.black, // Texto en color negro
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

// CONVERTIDOR DE ARCHIVOS
FilePickerResult? result; // Define result como una variable global dentro de la clase

class FileConverterPage extends StatefulWidget {
  @override
  _FileConverterPageState createState() => _FileConverterPageState();
}

class _FileConverterPageState extends State<FileConverterPage> {
  String? selectedFileType;
  String? fileName;
  Uint8List? fileBytes;  // To store selected file bytes
  final List<String> fileTypes = ['.docx', '.pdf', '.xlsx', '.txt'];

  // Function to select the file
  void selectFile() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileBytes = result!.files.single.bytes;
        fileName = result!.files.single.name;
      });
    } else {
      print('No file selected');
    }
  }

  // Function to rename the file with the selected extension
  void renameFile() {
    if (fileName != null && selectedFileType != null && fileBytes != null) {
      // Extract the original name without the extension
      String baseName = fileName!.split('.').first;

      // Create the new file name with the selected extension
      String newFileName = '$baseName$selectedFileType';

      // Trigger the download with the renamed file
      downloadWebFile(fileBytes!, newFileName);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Archivo renombrado y descargado como $newFileName'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, selecciona un archivo y un formato.'),
      ));
    }
  }

  // Function to download the file in the web environment
  void downloadWebFile(Uint8List bytes, String fileName) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 17, 43, 1),
        title: Text('UTB Tools', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/utb_tools_logo.jpeg',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Convertir Archivos',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black54,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    fileName ?? 'Selecciona o arrastra el archivo a convertir',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Icon(Icons.upload_file, color: Colors.black54),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Convertir A:', style: TextStyle(color: Colors.white)),
              dropdownColor: Color.fromRGBO(11, 17, 43, 1),
              value: selectedFileType,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              iconSize: 24,
              style: const TextStyle(color: Colors.white),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFileType = newValue;
                });
              },
              items: fileTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: renameFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text('Convertir'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fileName = null;
                      selectedFileType = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text('Cancelar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Colors.grey[400],
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'UTB Tools© 2024',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}