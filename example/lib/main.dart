import 'package:flutter/material.dart';
import 'package:myket_updater/myket_updater.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Myket Updater Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyketUpdateResult? _lastResult;
  bool _isLoading = false;

  Future<void> _checkForUpdate() async {
    setState(() {
      _isLoading = true;
      _lastResult = null;
    });

    final result = await MyketUpdater.checkForUpdate();

    setState(() {
      _isLoading = false;
      _lastResult = result;
    });
  }

  Future<void> _checkAndShowDialog() async {
    setState(() {
      _isLoading = true;
    });

    await MyketUpdater.checkAndShowDialog(context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Myket Updater Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Myket Updater',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Check for app updates on Myket (Iranian app store).',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _checkForUpdate,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: const Text('Check for Update'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isLoading ? null : _checkAndShowDialog,
              icon: const Icon(Icons.system_update),
              label: const Text('Check & Show Dialog'),
            ),
            const SizedBox(height: 24),
            if (_lastResult != null) ...[
              Text(
                'Last Result:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ResultRow(
                        label: 'Update Available',
                        value: _lastResult!.isUpdateAvailable.toString(),
                        valueColor: _lastResult!.isUpdateAvailable
                            ? Colors.green
                            : Colors.grey,
                      ),
                      _ResultRow(
                        label: 'Current Version',
                        value:
                            '${_lastResult!.currentVersionName} (${_lastResult!.currentVersionCode})',
                      ),
                      if (_lastResult!.isUpdateAvailable) ...[
                        _ResultRow(
                          label: 'Latest Version Code',
                          value: _lastResult!.versionCode.toString(),
                        ),
                        if (_lastResult!.description.isNotEmpty)
                          _ResultRow(
                            label: 'Description',
                            value: MyketUpdater.stripHtmlTags(
                              _lastResult!.description,
                            ),
                          ),
                      ],
                      if (_lastResult!.error)
                        _ResultRow(
                          label: 'Error',
                          value: _lastResult!.errorMessage,
                          valueColor: Colors.red,
                        ),
                      if (_lastResult!.myketNotInstalled)
                        const _ResultRow(
                          label: 'Note',
                          value: 'Myket app is not installed on this device',
                          valueColor: Colors.orange,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}
