import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class LoginWidget extends StatefulWidget {
    final int r, g, b;
    const LoginWidget({
            Key? key,
            required this.r,
            required this.g,
            required this.b,
            }) : super(key: key);
    @override
        State<LoginWidget> createState() => _LoginWidgetState();
}
class _LoginWidgetState extends State<LoginWidget> {
    bool showSignUp = false;
    // Login fields
    final TextEditingController userController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    // Sign-up fields
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    bool isRenter = false;
    File? personalPic;
    File? idPic;
    int selectedDay = 1;
    String selectedMonth = "Jan";
    int selectedYear = DateTime.now().year;
    final List<String> months = const [
        "Jan","Feb","Mar","Apr","May","Jun",
        "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    List<int> get days {
        int maxDays;
        switch (selectedMonth) {
            case "Apr":
            case "Jun":
            case "Sep":
            case "Nov":
                maxDays = 30;
                break;
            case "Feb":
                if ((selectedYear % 4 == 0 && selectedYear % 100 != 0) ||
                        (selectedYear % 400 == 0)) {
                    maxDays = 29;
                } else {
                    maxDays = 28;
                }
                break;
            default:
                maxDays = 31;
        }
        return List<int>.generate(maxDays, (i) => i + 1);
    }
    Future<void> pickImage(bool isPersonal) async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked != null) {
            setState(() {
                    if (isPersonal) {
                    personalPic = File(picked.path);
                    } else {
                    idPic = File(picked.path);
                    }
                    });
        }
    }
    @override
        Widget build(BuildContext context) {
            return Container(
                    color: Color.fromARGB(255, widget.r, widget.g, widget.b),
                    padding: const EdgeInsets.all(16),
                    child: showSignUp ? _buildSignUpForm(context) : _buildLoginForm(context),
                    );
        }
    Widget _buildLoginForm(BuildContext context) {
        return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                TextField(
                    controller: userController,
                    decoration: const InputDecoration(labelText: "Username"),
                    ),
                TextField(
                    controller: passController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    ),
                const SizedBox(height: 12),
                ElevatedButton(
                    onPressed: () {
                    showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                title: const Text("Login Action"),
                                content: Text(
                                    "Attempting login with:\nUser: ${userController.text}\nPass: ${passController.text}",
                                    ),
                                ),
                            );
                    },
child: const Text("Login"),
),
                TextButton(
                        onPressed: () {
                        setState(() {
                                showSignUp = true;
                                });
                        },
child: const Text("I don’t have any account!"),
),
                ],
                );
    }
    Widget _buildSignUpForm(BuildContext context) {
        return SingleChildScrollView(
                child: Column(
                    children: [
                    Row(
                        children: [
                        const Text("Renter:"),
                        Checkbox(
                            value: isRenter,
                            onChanged: (val) {
                            setState(() {
                                    isRenter = val ?? false;
                                    });
                            },
                            ),
                        ],
                       ),
                    TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(labelText: "First Name"),
                        ),
                    TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(labelText: "Last Name"),
                        ),
                    Row(
                            children: [
                            const Text("Personal Picture:"),
                            ElevatedButton(
                                onPressed: () => pickImage(true),
                                child: const Text("Upload..."),
                                ),
                            if (personalPic != null)
                            Image.file(personalPic!, width: 80, height: 80),
                            ],
                       ),
                    Row(
                            children: [
                            const Text("Birthday:"),
                            DropdownButton<int>(
                                value: selectedDay,
                                items: days
                                .map((d) => DropdownMenuItem(value: d, child: Text("$d")))
                                .toList(),
                                onChanged: (val) => setState(() => selectedDay = val!),
                                ),
                            DropdownButton<String>(
                                value: selectedMonth,
                                items: months
                                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                                .toList(),
                                onChanged: (val) => setState(() => selectedMonth = val!),
                                ),
                            DropdownButton<int>(
                                value: selectedYear,
                                items: List<int>.generate(100, (i) => DateTime.now().year - i)
                                .map((y) => DropdownMenuItem(value: y, child: Text("$y")))
                                .toList(),
                                onChanged: (val) => setState(() => selectedYear = val!),
                                ),
                            ],
                            ),
                            Row(
                                    children: [
                                    const Text("ID Picture:"),
                                    ElevatedButton(
                                        onPressed: () => pickImage(false),
                                        child: const Text("Upload..."),
                                        ),
                                    if (idPic != null) Image.file(idPic!, width: 80, height: 80),
                                    ],
                               ),
                            ElevatedButton(
                                    onPressed: () {
                                    final birthday =
                                    "$selectedDay $selectedMonth $selectedYear";
                                    showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                title: const Text("Sign Up"),
                                                content: Text(
                                                    "Registration submitted:\nFirst Name: ${firstNameController.text}\nLast Name: ${lastNameController.text}\nBirthday: $birthday",
                                                    ),
                                                ),
                                            );
                                    },
child: const Text("Register"),
),
                            ],
                            ),
                            );
    }
}
