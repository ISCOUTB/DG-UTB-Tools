import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:math';

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
        '/convert-files': (context) => FileConverterPage(),
        '/schedule': (context) => SchedulePage(),
      },
    );
  }
}

// Página principal con los botones para las diferentes funciones
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
                    Navigator.pushNamed(context, '/convert-files');
                  }),
                  const SizedBox(height: 20),
                  _buildButton('CALCULA TU NOTA', () {
                    Navigator.pushNamed(context, '/calculate-grade');
                  }),
                  const SizedBox(height: 20),
                  _buildButton('GENERAR HORARIO', () {
                    Navigator.pushNamed(context, '/schedule');
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: const Text(
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

// Página para calcular la nota final
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
        backgroundColor: Color.fromRGBO(11, 17, 43, 1),
        title: Text(
          'UTB Tools',
          style: TextStyle(color: Colors.white),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            '⭠',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
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
                      Text('Segunda nota', style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: corte2Controller,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
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
                      backgroundColor: Color(0xFF0B7B8E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: calcularNotaFinal,
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                notaFinalNecesaria > 0 ? notaFinalNecesaria.toStringAsFixed(2) : 'RESULTADO',
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

// Página para convertir archivos
class FileConverterPage extends StatefulWidget {
  @override
  _FileConverterPageState createState() => _FileConverterPageState();
}

class _FileConverterPageState extends State<FileConverterPage> {
  FilePickerResult? result;
  String? selectedFileType;
  String? fileName;
  Uint8List? fileBytes;

  final List<String> fileTypes = ['.docx', '.pdf', '.xlsx', '.txt'];

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

  void renameFile() {
    if (fileName != null && selectedFileType != null && fileBytes != null) {
      String baseName = fileName!.split('.').first;
      String newFileName = '$baseName$selectedFileType';
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

// Nueva página de generación de horarios con colores aleatorios
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController subjectController = TextEditingController();
  String selectedDay = 'Lunes';
  String selectedTime = '07:00 - 07:50';
  Map<String, Map<String, String>> schedule = {};
  Map<String, Color> subjectColors = {}; // Mapa para asignar colores aleatorios a las materias

  final List<String> hours = [
    '07:00 - 07:50',
    '08:00 - 08:50',
    '09:00 - 09:50',
    '10:00 - 10:50',
    '11:00 - 11:50',
    '12:00 - 12:50',
    '13:00 - 13:50',
    '14:00 - 14:50',
    '15:00 - 15:50',
    '16:00 - 16:50',
    '17:00 - 17:50',
    '18:00 - 18:50',
    '19:00 - 19:50',
    '20:00 - 20:50',
    '21:00 - 21:50',
  ];

  final List<String> days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

  void addSubjectToSchedule() {
    if (subjectController.text.isNotEmpty) {
      setState(() {
        if (schedule[selectedTime] == null) {
          schedule[selectedTime] = {};
        }
        schedule[selectedTime]![selectedDay] = subjectController.text;

        // Asignar un color aleatorio a la materia si no tiene uno
        if (!subjectColors.containsKey(subjectController.text)) {
          subjectColors[subjectController.text] = getRandomColor();
        }
      });
      subjectController.clear();
    }
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar Horario'),
        backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      ),
      backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Ingresa una materia, selecciona el día y la hora:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: subjectController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Materia',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[600],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Color.fromRGBO(11, 17, 43, 1),
                    value: selectedDay,
                    items: days.map((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedDay = newValue!;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Color.fromRGBO(11, 17, 43, 1),
                    value: selectedTime,
                    items: hours.map((String time) {
                      return DropdownMenuItem<String>(
                        value: time,
                        child: Text(time, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedTime = newValue!;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addSubjectToSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(11, 123, 142, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Agregar Materia'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.blue, width: 2),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(1),
                    7: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          color: Color.fromRGBO(11, 123, 142, 1),
                          child: Center(
                            child: Text('Horas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        ...days.map(
                              (day) => Container(
                            padding: EdgeInsets.all(8.0),
                            color: Color.fromRGBO(11, 123, 142, 1),
                            child: Center(
                              child: Text(
                                day,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...hours.map(
                          (hour) => TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue[300],
                            child: Center(
                              child: Text(
                                hour,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ...days.map(
                                (day) {
                              String? subject = schedule[hour] != null ? schedule[hour]![day] : null;
                              return Container(
                                height: 50,
                                padding: EdgeInsets.all(8.0),
                                color: subject != null ? subjectColors[subject] : Colors.grey[300],
                                child: Center(
                                  child: Text(
                                    subject ?? '',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ],
                      ),
                    ).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}