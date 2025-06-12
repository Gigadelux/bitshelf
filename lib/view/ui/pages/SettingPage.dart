import 'package:bitshelf/core/BookCRUDStrategy/BookDeferredDataStrategy.dart';
import 'package:bitshelf/core/BookCRUDStrategy/BookFluxDataStrategy.dart';
import 'package:bitshelf/data/gateway/CSVBookGateway.dart';
import 'package:flutter/material.dart';
import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/data/gateway/BookFakeGateway.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  // Store temporary values for strategy and gateway selection
  String? tempSelectedStrategy;
  String? tempSelectedGateway;
  Map<String, String>? tempConfig;

  @override
  Widget build(BuildContext context) {
    final appConfig = Appconfig(); //getInstance
    final configKeys = appConfig.gatewayConfig.keys.toList();
    final controllers = <String, TextEditingController>{};
    for (var key in configKeys) {
      controllers[key] = TextEditingController(text: tempConfig?[key] ?? appConfig.gatewayConfig[key]);
    }
    String selectedGateway = tempSelectedGateway ?? appConfig.bookRepository.runtimeType.toString();
    List<String> gatewayOptions = [
      'BookFakeGateway',
      'Csvbookgateway',
    ];
    String selectedStrategy = tempSelectedStrategy ?? appConfig.bookDataStrategy.runtimeType.toString();
    List<String> strategyOptions = [
      'Bookfluxdatastrategy',
      'Bookdeferreddatastrategy',
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text("Settings", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          // Strategy Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                const Text('Strategy: ', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedStrategy,
                  items: strategyOptions.map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null && value != selectedStrategy) {
                      setState(() {
                        tempSelectedStrategy = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          ...configKeys.map((key) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: TextField(
              controller: controllers[key],
              decoration: InputDecoration(
                labelText: key,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                tempConfig = tempConfig ?? Map<String, String>.from(appConfig.gatewayConfig);
                tempConfig![key] = value;
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                const Text('Gateway: ', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedGateway,
                  items: gatewayOptions.map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null && value != selectedGateway) {
                      setState(() {
                        tempSelectedGateway = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: MaterialButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                try {
                  // Apply all changes at once
                  for (var key in configKeys) {
                    appConfig.gatewayConfig[key] = controllers[key]!.text;
                  }
                  appConfig.updateGatewayConfig(appConfig.gatewayConfig);
                  if ((tempSelectedGateway ?? selectedGateway) == 'BookFakeGateway') {
                    appConfig.updateRepository(BookFakeGateway(appConfig.gatewayConfig));
                  } else if ((tempSelectedGateway ?? selectedGateway) == 'Csvbookgateway') {
                    appConfig.updateRepository(Csvbookgateway(appConfig.gatewayConfig));
                  }
                  if ((tempSelectedStrategy ?? selectedStrategy) == 'Bookfluxdatastrategy') {
                    appConfig.updateStrategy(Bookfluxdatastrategy(appConfig.bookRepository));
                  } else if ((tempSelectedStrategy ?? selectedStrategy) == 'Bookdeferreddatastrategy') {
                    appConfig.updateStrategy(Bookdeferreddatastrategy(appConfig.bookRepository));
                  }
                  setState(() {
                    tempSelectedGateway = null;
                    tempSelectedStrategy = null;
                    tempConfig = null;
                  });
                  _showDesktopToast(context, 'Settings saved successfully');
                } catch (e) {
                  _showDesktopToast(context, 'Error: $e', error: true);
                }
              },
              child: const Text('Save Settings', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _showDesktopToast(BuildContext context, String message, {bool error = false}) {
    final color = error ? Colors.red : Colors.green;
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}