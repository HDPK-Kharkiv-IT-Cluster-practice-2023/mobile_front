import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String defaultServer = '127.0.0.1:5000';
String currentServer = '127.0.0.1:5000';

void main() => runApp(ServerSelection());

class ServerSelection extends StatelessWidget {
  const ServerSelection({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Servers(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Servers extends StatefulWidget {
  const Servers({Key? key});

  @override
  State<Servers> createState() => _ServersState();
}

Future<String> getStatus(String url) async {
  await Future.delayed(Duration(milliseconds: 250));
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('status')) {
        String status = data['status'];
        return 'OK';
      } else {
        // Handle the case where the response doesn't contain the expected 'status' key.
        return 'Invalid Data';
      }
    } else {
      // Handle non-200 HTTP status codes (e.g., 404, 500, etc.).
      return 'Not OK';
    }
  } catch (e) {
    // Handle exceptions that may occur during the HTTP request or JSON decoding.
    return 'Error: $e';
  }
}

class _ServersState extends State<Servers> {
  late Future<String> serverStatus;
  late Future<String> customServerStatus;
  late TextEditingController controller;
  String customServer = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    serverStatus = getStatus('http://127.0.0.1:5000/api/v1/status');
    customServerStatus = getStatus('http://${customServer}/api/v1/status');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateCustomServer() {
    setState(() {
      customServer = controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Server Selection'),
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            serverStatus = getStatus('http://127.0.0.1:5000/api/v1/status');
            customServerStatus =
                getStatus('http://${customServer}/api/v1/status');
          });
        },
        child: ListView(
          children: [
            Card(
                child: InkWell(
              onTap: () {},
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.dns,
                          size: 30,
                        ),
                      ),
                      Text('Default server'),
                      Spacer(),
                      FutureBuilder<String>(
                        future: serverStatus,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Icon(Icons.trip_origin,
                                color: Colors.orange);
                          } else if (snapshot.hasError) {
                            return Icon(Icons.trip_origin, color: Colors.red);
                          } else {
                            return Icon(Icons.trip_origin,
                                color: snapshot.data == 'OK'
                                    ? Colors.green
                                    : Colors.red);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Card(
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.dns,
                          size: 30,
                        ),
                      ),
                      Text('Custom server'),
                      TextButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Enter your server:'),
                            content: TextField(
                              controller:
                                  controller, // Use the TextEditingController
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Server address',
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  updateCustomServer(); // Update customServer when OK is pressed
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                        child: Icon(Icons.edit),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                      Spacer(),
                      FutureBuilder<String>(
                        future: customServerStatus,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Icon(Icons.trip_origin,
                                color: Colors.orange);
                          } else if (snapshot.hasError) {
                            return Icon(Icons.trip_origin, color: Colors.red);
                          } else {
                            return Icon(Icons.trip_origin,
                                color: snapshot.data == 'OK'
                                    ? Colors.green
                                    : Colors.red);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
