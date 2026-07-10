import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class AgencyRegistrationScreen extends ConsumerStatefulWidget {
  const AgencyRegistrationScreen({super.key});

  @override
  ConsumerState<AgencyRegistrationScreen> createState() => _AgencyRegistrationScreenState();
}

class _AgencyRegistrationScreenState extends ConsumerState<AgencyRegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _agencyNameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _agencyNameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _agencyNameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/v1'));
      
      await dio.post('/auth/register', data: {
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      final loginResponse = await dio.post(
        '/auth/login',
        data: FormData.fromMap({
          'username': _emailController.text,
          'password': _passwordController.text,
        }),
      );
      final token = loginResponse.data['access_token'];

      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post('/agencies/', data: {
        'name': _agencyNameController.text,
      });

      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Registration failed. Check connection.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.15),
                backgroundBlendMode: BlendMode.screen,
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.1, duration: 3.seconds),
          ),
          
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(32),
                decoration: AppTheme.glassDecoration.copyWith(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.rocket_launch_rounded, size: 48, color: AppTheme.accentColor)
                      .animate().slideY(begin: -0.2, end: 0).fadeIn(),
                    const SizedBox(height: 16),
                    Text(
                      'Launch Your Agency',
                      style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                      textAlign: TextAlign.center,
                    ).animate().slideY(begin: 0.2, end: 0).fadeIn(delay: 100.ms),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your details to create your workspace.',
                      style: GoogleFonts.outfit(fontSize: 14, color: AppTheme.textSecondary),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 32),
                    
                    TextField(
                      controller: _agencyNameController,
                      decoration: const InputDecoration(
                        labelText: 'Agency Name',
                        prefixIcon: Icon(Icons.business),
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1, end: 0),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading 
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('Create Workspace'),
                    ).animate().fadeIn(delay: 600.ms).scaleXY(begin: 0.9, end: 1),
                    
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!, 
                        style: GoogleFonts.outfit(color: Colors.redAccent, fontWeight: FontWeight.w500), 
                        textAlign: TextAlign.center
                      ).animate().shake(),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
