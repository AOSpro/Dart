import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'trans.dart';

void main() => runApp(MaterialApp(home: ColorRuleApp()));

class ColorRuleApp extends StatefulWidget {
  @override
  _ColorRuleAppState createState() => _ColorRuleAppState();
}

const Color init = Color(0xffff0000);

class _ColorRuleAppState extends State<ColorRuleApp> {
  // اللون الابتدائي الافتراضي
  Color pickerColor = init;
  Color comp = Trans.complementary(init);
  List<Color> anal = Trans.analogous(init); //2
  List<Color> mono = Trans.monochromatic(init); //2
  List<Color> tri = Trans.triadic(init); //2
  List<Color> tet = Trans.tetradic(init); //3

  void updateColors(Color color) {
    setState(() {
      comp = Trans.complementary(color);
      anal = Trans.analogous(color);
      mono = Trans.monochromatic(color);
      tri = Trans.triadic(color);
      tet = Trans.tetradic(color);
    });
  }

  void showPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              pickerColor = color;
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              updateColors(pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("60-30-10 Color Rule"),
        actions: [
          IconButton(icon: const Icon(Icons.palette), onPressed: showPicker)
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [_colorPanel("your color", pickerColor)],
          ),
          Row(
            children: [
              _colorPanel("complementary", comp),
            ],
          ),
          Row(
            children: [
              _colorPanel("analogous 1", anal[0]),
              _colorPanel("analogous 2", anal[1]),
            ],
          ),
          Row(
            children: [
              _colorPanel("monochromatic 1", mono[0]),
              _colorPanel("monochromatic 2", mono[1]),
            ],
          ),
          Row(
            children: [
              _colorPanel("triadic 1", tri[0]),
              _colorPanel("triadic 2", tri[1]),
            ],
          ),
          Row(
            children: [
              _colorPanel("tetradic 1", tet[0]),
              _colorPanel("tetradic 2", tet[1]),
              _colorPanel("tetradic 3", tet[2]),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: showPicker,
              icon: const Icon(Icons.colorize),
              label: const Text("Change Base Color"),
            ),
          ),
          _creditsSection(),
        ],
      ),
    );
  }

  Widget _colorPanel(String label, Color color) {
    // تحديد لون النص (أبيض أو أسود) بناءً على سطوع الخلفية
    Color textColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? Colors.black
            : Colors.white;

    return Expanded(
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style:
                    TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              "#${color.value.toRadixString(16).substring(2).toUpperCase()}",
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _creditsSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[200],
      width: double.infinity,
      child: const Column(
        children: [
          Text("Owner: AOSpro", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Call: t.me/aospro", style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }
}
