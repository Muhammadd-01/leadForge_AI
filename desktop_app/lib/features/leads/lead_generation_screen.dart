import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class LeadGenerationScreen extends ConsumerStatefulWidget {
  const LeadGenerationScreen({super.key});

  @override
  ConsumerState<LeadGenerationScreen> createState() => _LeadGenerationScreenState();
}

class _LeadGenerationScreenState extends ConsumerState<LeadGenerationScreen> {
  final _queryController = TextEditingController();
  final _locationController = TextEditingController();
  final _instructionsController = TextEditingController();
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  @override
  void dispose() {
    _queryController.dispose();
    _locationController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _generateLeads() async {
    if (_queryController.text.isEmpty || _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in query and location')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
      _isSuccess = false;
    });

    try {
      final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/v1'));
      dio.options.headers['Authorization'] = 'Bearer dummy_token';

      final response = await dio.post('/ai-leads/generate', data: {
        'query': _queryController.text,
        'location': _locationController.text,
        'instructions': _instructionsController.text.isEmpty 
            ? 'Find quality leads' 
            : _instructionsController.text,
      });

      setState(() {
        _message = response.data['message'] ?? 'Lead generation started in background.';
        _isSuccess = true;
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to start generation: ${e.toString()}';
        _isSuccess = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by AppShell
      appBar: AppBar(
        title: const Text('AI Lead Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.glassDecoration.copyWith(
                border: Border.all(color: AppTheme.accentColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: AppTheme.accentColor, size: 32)
                      .animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.1, duration: 1000.ms),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover New Prospects',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Use OpenStreetMap and local LLMs to find and enrich leads.',
                          style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.1, end: 0).fadeIn(duration: 400.ms),
            
            const SizedBox(height: 32),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.glassDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _queryController,
                    decoration: const InputDecoration(
                      labelText: 'Business Type (e.g., Plumber, Restaurant)',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05, end: 0),
                  const SizedBox(height: 16),
                  
                  TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location (e.g., London, New York)',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.05, end: 0),
                  const SizedBox(height: 16),
                  
                  TextField(
                    controller: _instructionsController,
                    decoration: const InputDecoration(
                      labelText: 'AI Instructions (Optional)',
                      hintText: 'e.g. Only score highly if they have a website',
                      prefixIcon: Icon(Icons.psychology),
                    ),
                    maxLines: 3,
                  ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.05, end: 0),
                  const SizedBox(height: 32),
                  
                  ElevatedButton(
                    onPressed: _isLoading ? null : _generateLeads,
                    child: _isLoading 
                      ? const SizedBox(
                          height: 20, width: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Find Leads'),
                            const SizedBox(width: 8),
                            const Icon(Icons.rocket_launch, size: 18),
                          ],
                        ),
                  ).animate().fadeIn(delay: 500.ms).scaleXY(begin: 0.95, end: 1),
                ],
              ),
            ),
            
            if (_message != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isSuccess ? AppTheme.secondaryAccent.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isSuccess ? AppTheme.secondaryAccent.withOpacity(0.5) : Colors.red.withOpacity(0.5)
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isSuccess ? Icons.check_circle_outline : Icons.error_outline, 
                      color: _isSuccess ? AppTheme.secondaryAccent : Colors.redAccent
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _message!, 
                        style: GoogleFonts.outfit(
                          color: _isSuccess ? AppTheme.secondaryAccent : Colors.redAccent,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),
            ]
          ],
        ),
      ),
    );
  }
}
