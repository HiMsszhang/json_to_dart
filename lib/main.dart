import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Json to Dart Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  String? _errorText;

  String _mapBuffer = '';

  @override
  void initState() {
    _classNameController.text = "GenerateClassName";
    super.initState();
  }

  void _incrementCounter() {
    _outputController.text = '';
    _mapBuffer = '';
    _errorText = '';
    try {
      final jsonData = json.decode(_inputController.text) as Map<String, dynamic>;
      setState(() {
        _outputController.text = _generateClassTemplate(_classNameController.text, jsonData);
      });
    } on FormatException {
      setState(() {
        _errorText = '请输入正确的json格式';
      });
    }
  }

  String _generateClassTemplate(String className, Map<String, dynamic> jsonData) {
    _mapBuffer = '';
    final classFieldsString = _generateClassFieldsString(jsonData);
    final classConstructorString = _generateClassConstructorString(jsonData);
    final classFromJsonString = _generateClassFromJsonString(jsonData);
    final class2JsonString = _generateClass2JsonString(jsonData);
    return '''
    class $className {
      $classFieldsString
    
      $className({$classConstructorString});
    
      factory $className.fromJson(Map<String, dynamic> json) {
        return $className(
              $classFromJsonString
        );
      }
      Map<String,dynamic> toJson(){
      Map<String,dynamic> data = {};
      
     $class2JsonString

      return data;
      }
    }
    $_mapBuffer
  ''';
  }

  _generateClassFieldsString(Map<String, dynamic> jsonData) {
    StringBuffer classFieldsString = StringBuffer();
    jsonData.forEach((key, value) {
      final keyStrings = key.split('#');
      final noteStr = keyStrings.last;
      final keyStr = keyStrings.first;
      if (value is String) {
        if (DateTime.tryParse(value) == null) {
          classFieldsString.writeln('    ///$noteStr\n   String? $keyStr;\n');
        } else {
          classFieldsString.writeln('    ///$noteStr\n   DateTime? $keyStr;\n');
        }
      }
      if (value is int) {
        classFieldsString.writeln('    ///$noteStr\n   int? $keyStr;\n');
      }
      if (value is double) {
        classFieldsString.writeln('    ///$noteStr\n   double? $keyStr;\n');
      }
      if (value is bool) {
        classFieldsString.writeln('    ///$noteStr\n   bool? $keyStr;\n');
      }
      if (value is Map) {
        classFieldsString.writeln('    ///$noteStr\n    ${keyStr.split('').first.toUpperCase()}${keyStr.substring(1)}? $keyStr;\n');
        _mapBuffer += _generateClassTemplate(keyStr.split('').first.toUpperCase() + keyStr.substring(1), value as Map<String, dynamic>);
      }
      if (value is List) {
        if (value.isNotEmpty) {
          if (value.first is String) {
            classFieldsString.writeln('    ///$noteStr\n   List<String>? $keyStr;\n');
          }
          if (value.first is int) {
            classFieldsString.writeln('    ///$noteStr\n    List<int>? $keyStr;\n');
          }
          if (value.first is double) {
            classFieldsString.writeln('    ///$noteStr\n     List<double>? $keyStr;\n');
          }
          if (value.first is bool) {
            classFieldsString.writeln('    ///$noteStr\n     List<bool>? $keyStr;\n');
          }
          if (value.first is Map) {
            classFieldsString.writeln('    ///$noteStr\n     List<${keyStr.split('').first.toUpperCase()}${keyStr.substring(1)}Item>? $keyStr;\n');
            _mapBuffer += _generateClassTemplate('${keyStr.split('').first.toUpperCase()}${keyStr.substring(1)}Item', value.first as Map<String, dynamic>);
          }
        } else {
          classFieldsString.writeln('    ///$noteStr\n    List<dynamic>? $keyStr;\n');
        }
      }
    });
    return classFieldsString;
  }

  _generateClassConstructorString(Map<String, dynamic> jsonData) {
    return jsonData.keys.toList().map((field) => '    this.${field.split('#').first},\n').join();
  }

  String _generateClassFromJsonString(Map<String, dynamic> jsonData) {
    StringBuffer classFromJsonString = StringBuffer();

    jsonData.forEach((key, value) {
      final keyStrings = key.split('#');
      final keyStr = keyStrings.first;
      if (value is String) {
        if (DateTime.tryParse(value) != null) {
          classFromJsonString.writeln('      $keyStr:DateTime.tryParse(json[\'$keyStr\'] ?? \'\'),\n');
        } else {
          classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
        }
      }
      if (value is int) {
        classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
      }
      if (value is double) {
        classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
      }
      if (value is bool) {
        classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
      }
      if (value is Map) {
        classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'] != null ? ${keyStr.split('').first.toUpperCase()}${keyStr.substring(1)}.fromJson(json[\'$keyStr\']) : null,');
      }
      if (value is List) {
        if (value.isNotEmpty) {
          if (value.first is String) {
            classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
          }
          if (value.first is int) {
            classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
          }
          if (value.first is bool) {
            classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
          }
          if (value.first is double) {
            classFromJsonString.writeln('      $keyStr: json[\'$keyStr\'],\n');
          }
          if (value.first is Map) {
            classFromJsonString.writeln(
                '      $keyStr: json[\'$keyStr\']?.map<${keyStr.split('').first.toUpperCase()}${keyStr.substring(1)}Item>((e)=>${keyStr.split('').first.toUpperCase()}${keyStr.substring(1)}Item'
                '.fromJson(e)).toList(),\n');
          }
        } else {
          classFromJsonString.writeln('      $keyStr: [],\n');
        }
      }
    });
    return classFromJsonString.toString();
  }

  _generateClass2JsonString(Map<String, dynamic> jsonData) {
    StringBuffer class2JsonString = StringBuffer();
    jsonData.forEach((key, value) {
      final keyStrings = key.split('#');
      final keyStr = keyStrings.first;
      if (value is String) {
        if (DateTime.tryParse(value) != null) {
          class2JsonString.writeln('      data[\'$keyStr\']=$keyStr.toString();\n');
        } else {
          class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
        }
      }
      if (value is int) {
        class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
      }
      if (value is double) {
        class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
      }
      if (value is bool) {
        class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
      }
      if (value is Map) {
        class2JsonString.writeln('      data[\'$keyStr\']=$keyStr?.toJson();\n');
      }
      if (value is List) {
        if (value.isNotEmpty) {
          if (value.first is String) {
            class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
          }
          if (value.first is int) {
            class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
          }
          if (value.first is bool) {
            class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
          }
          if (value.first is double) {
            class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
          }
          if (value.first is Map) {
            class2JsonString.writeln('      data[\'$keyStr\']=$keyStr?.map((e)=>e.toJson()).toList();\n');
          }
        } else {
          class2JsonString.writeln('      data[\'$keyStr\']=$keyStr;\n');
        }
      }
    });
    return class2JsonString.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('请输入需要生成的Dart类名：'),
                    Container(
                      width: 500,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        onChanged: (val) {
                          if (_classNameController.text == '') {
                            Future.delayed(const Duration(seconds: 2), () {
                              if (_classNameController.text == '') {
                                setState(() {
                                  _classNameController.text = 'GenerateClassName';
                                });
                              }
                            });
                          }
                        },
                        controller: _classNameController,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black),
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          alignLabelWithHint: false,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(_errorText ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      const Text('输入--json格式'),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height / 1.25,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xff1d1f21),
                          border: Border.all(width: 2, color: Colors.black12),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          cursorColor: Colors.white38,
                          controller: _inputController,
                          maxLines: 100000,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('输出--dart model'),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: MediaQuery.of(context).size.height / 1.25,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xff1d1f21),
                          border: Border.all(width: 2, color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          cursorColor: Colors.white38,
                          controller: _outputController,
                          maxLines: 100000,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
