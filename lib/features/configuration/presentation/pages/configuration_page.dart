import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/configuration_bloc.dart';
import '../../../../core/config/app_theme.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _keyController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup Connection')),
      body: BlocListener<ConfigurationBloc, ConfigurationState>(
        listener: (context, state) {
          if (state is ConfigurationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Connection Successful!')),
            );
            // Navigate to Auth or Main screen
            context.go('/login');
          } else if (state is ConfigurationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.settings_input_antenna,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Connect to Store',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your WordPress site URL and License Key to continue.',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      labelText: 'Site URL',
                      hintText: 'https://example.com',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.link),
                    ),
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Site URL';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _keyController,
                    decoration: const InputDecoration(
                      labelText: 'License Key',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter License Key';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<ConfigurationBloc, ConfigurationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is ConfigurationLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ConfigurationBloc>().add(
                                    SubmitConfigurationEvent(
                                      siteUrl: _urlController.text.trim(),
                                      licenseKey: _keyController.text.trim(),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: state is ConfigurationLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Connect'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
