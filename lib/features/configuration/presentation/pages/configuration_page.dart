// features/configuration/presentation/pages/configuration_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/network/custom_http_client.dart';
import '../../../../core/routes/route_constants.dart';
import '../bloc/configuration_bloc.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  bool _isValidUrl = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your website URL';
    }
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return 'Please enter a valid URL (e.g., https://myshop.com)';
    }
    return null;
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text.trim();
      final cleanedUrl = url.endsWith('/') ? url : '$url';
      context.read<ConfigurationBloc>().add(SaveSiteUrl(cleanedUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<ConfigurationBloc, ConfigurationState>(
        listener: (context, state) {
          if (state is ConfigurationSaved) {
            // Initialize Dio with the new base URL
            DioClient.initialize(state.config.baseUrl);

            // Navigate to login
            context.go(RouteConstants.loginPath);
          } else if (state is ConfigurationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade700,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 64 : 32,
                    vertical: 32,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo / Icon
                        Icon(
                          Icons.storefront_rounded,
                          size: isDesktop ? 120 : 100,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 32),

                        // Title
                        Text(
                          'Welcome to SellSheba Connect',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Subtitle
                        Text(
                          'Enter your shop website URL to get started',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground.withOpacity(0.7),
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),

                        // URL Input Field
                        TextFormField(
                          controller: _urlController,
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                            hintText: 'https://myshop.com',
                            labelText: 'Website URL',
                            prefixIcon: const Icon(Icons.link_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                          ),
                          validator: _validateUrl,
                          onChanged: (value) {
                            setState(() {
                              _isValidUrl =
                                  _validateUrl(value) == null &&
                                  value.isNotEmpty;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 32),

                        // Continue Button
                        ElevatedButton(
                          onPressed:
                              state is ConfigurationSaving || !_isValidUrl
                              ? null
                              : _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: state is ConfigurationSaving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Continue',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                        ),

                        if (state is ConfigurationLoading) ...[
                          const SizedBox(height: 20),
                          const LinearProgressIndicator(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
