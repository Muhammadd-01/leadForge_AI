import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class CampaignsScreen extends ConsumerStatefulWidget {
  const CampaignsScreen({super.key});

  @override
  ConsumerState<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends ConsumerState<CampaignsScreen> {
  final _nameController = TextEditingController();
  final _templateController = TextEditingController();
  String _campaignType = 'email';
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _templateController.dispose();
    super.dispose();
  }

  Future<void> _createCampaign() async {
    if (_nameController.text.isEmpty || _templateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in name and template', style: GoogleFonts.outfit()),
          backgroundColor: Colors.redAccent,
        ),
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

      final response = await dio.post('/campaigns/', data: {
        'name': _nameController.text,
        'type': _campaignType,
        'template_content': _templateController.text,
      });

      setState(() {
        _message = 'Campaign created: ${response.data['name']}';
        _isSuccess = true;
        
        // Clear fields on success
        _nameController.clear();
        _templateController.clear();
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to create campaign: ${e.toString()}';
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
      backgroundColor: Colors.transparent, // Handled by AppShell
      appBar: AppBar(
        title: const Text('Campaigns'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.glassDecoration.copyWith(
                border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.campaign, color: AppTheme.primaryColor, size: 32)
                      .animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.1, duration: 1500.ms),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Outreach Campaign',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Automate your cold email and WhatsApp messaging.',
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Campaign Name',
                      prefixIcon: Icon(Icons.label_outline),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05, end: 0),
                  
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    value: _campaignType,
                    decoration: const InputDecoration(
                      labelText: 'Campaign Type',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    dropdownColor: AppTheme.surfaceColor,
                    items: [
                      DropdownMenuItem(
                        value: 'email', 
                        child: Row(
                          children: [
                            const Icon(Icons.email, size: 18, color: AppTheme.textSecondary),
                            const SizedBox(width: 8),
                            Text('Email', style: GoogleFonts.outfit(color: AppTheme.textPrimary)),
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'whatsapp', 
                        child: Row(
                          children: [
                            const Icon(Icons.phone_android, size: 18, color: AppTheme.textSecondary),
                            const SizedBox(width: 8),
                            Text('WhatsApp', style: GoogleFonts.outfit(color: AppTheme.textPrimary)),
                          ],
                        )
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        if (val != null) _campaignType = val;
                      });
                    },
                  ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.05, end: 0),
                  
                  const SizedBox(height: 16),
                  
                  TextField(
                    controller: _templateController,
                    decoration: const InputDecoration(
                      labelText: 'Message Template',
                      hintText: 'Hi {{first_name}}, I noticed your business...',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                  ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.05, end: 0),
                  
                  const SizedBox(height: 32),
                  
                  ElevatedButton(
                    onPressed: _isLoading ? null : _createCampaign,
                    child: _isLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Save Campaign'),
                            const SizedBox(width: 8),
                            const Icon(Icons.save, size: 18),
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
