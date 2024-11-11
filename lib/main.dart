import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormA - Abad Oriol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'M08',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'C',
                style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulari Exemple"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: <Widget>[
              FormTitle(title: 'Formulari Exemple'),
              SizedBox(height: 16),

              // Group Choice Chips inside a bordered container
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabelGroup(label: 'Opció de Chip'),
                    FormBuilderChoiceChip<String>(  
                      name: 'choice_chip',
                      options: [
                        FormBuilderChipOption(
                          value: 'Opció 1',
                          child: SizedBox(
                            width: 250, // Adjust the width of the chip container
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/flutter.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 2),
                                const Text('Opció 1'),
                              ],
                            ),
                          ),
                        ),
                        FormBuilderChipOption(
                          value: 'Opció 2',
                          child: SizedBox(
                            width: 250,
                            child: Row(
                              children: [
                                const SizedBox(width: 2),
                                const Text('Opció 2'),
                              ],
                            ),
                          ),
                        ),
                        FormBuilderChipOption(
                          value: 'Opció 3',
                          child: SizedBox(
                            width: 250,
                            child: Row(
                              children: [
                                const SizedBox(width: 2),
                                const Text('Opció 3'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Switch
              FormLabelGroup(label: 'Switch'),
              FormBuilderSwitch(
                name: 'switch_field',
                title: Text('Activar funció'),
              ),
              
              // Text Field
              FormLabelGroup(label: 'Text Field'),
              FormBuilderTextField(
                name: 'text_field',
                decoration: InputDecoration(
                  labelText: 'Escriu alguna cosa',
                ),
              ),

              // Dropdown Field
              FormLabelGroup(label: 'Dropdown Field'),
              FormBuilderDropdown<String>(
                name: 'dropdown_field',
                decoration: InputDecoration(
                  labelText: 'Selecciona una opció',
                ),
                items: [
                  DropdownMenuItem(value: 'Opció 1', child: Text('Opció 1')),
                  DropdownMenuItem(value: 'Opció 2', child: Text('Opció 2')),
                  DropdownMenuItem(value: 'Opció 3', child: Text('Opció 3')),
                ],
              ),

              // Radio Group
              FormLabelGroup(label: 'Radio Group'),
              FormBuilderRadioGroup<String>(
                name: 'radio_group',
                decoration: InputDecoration(labelText: 'Selecciona una opció'),
                options: [
                  FormBuilderFieldOption(value: 'Opció A', child: Text('Opció A')),
                  FormBuilderFieldOption(value: 'Opció B', child: Text('Opció B')),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formValues = _formKey.currentState?.value;

            String summary = 'Resumen de las opciones seleccionadas:\n';
            summary += 'Choice Chip: ${formValues?['choice_chip']}\n';
            summary += 'Switch: ${formValues?['switch_field']}\n';
            summary += 'Text Field: ${formValues?['text_field']}\n';
            summary += 'Dropdown: ${formValues?['dropdown_field']}\n';
            summary += 'Radio Group: ${formValues?['radio_group']}';

            alertDialog(context, summary);
          } else {
            print("Validació fallida");
            alertDialog(context, "Error en la validación.");
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.send),
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Formulari enviat!"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

class FormLabelGroup extends StatelessWidget {
  final String label;
  const FormLabelGroup({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  final String title;
  const FormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
