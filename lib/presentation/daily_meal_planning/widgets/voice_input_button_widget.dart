import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Voice input button widget for meal planning commands
/// Supports commands like 'Suggest diabetic-friendly lunch' or 'Replace with vegetarian option'
class VoiceInputButtonWidget extends StatefulWidget {
  final Function(String) onVoiceCommand;

  const VoiceInputButtonWidget({Key? key, required this.onVoiceCommand})
    : super(key: key);

  @override
  State<VoiceInputButtonWidget> createState() => _VoiceInputButtonWidgetState();
}

class _VoiceInputButtonWidgetState extends State<VoiceInputButtonWidget>
    with SingleTickerProviderStateMixin {
  bool _isListening = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      setState(() => _isListening = false);
      _animationController.stop();
      return;
    }

    setState(() => _isListening = true);
    _animationController.repeat(reverse: true);

    // Simulate voice recognition
    await Future.delayed(const Duration(seconds: 2));

    if (mounted && _isListening) {
      setState(() => _isListening = false);
      _animationController.stop();

      // Simulate recognized command
      final commands = [
        'Suggest diabetic-friendly lunch',
        'Replace with vegetarian option',
        'Show low calorie breakfast',
        'Find high protein dinner',
      ];

      widget.onVoiceCommand(commands[DateTime.now().second % commands.length]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voice command processed'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isListening ? _scaleAnimation.value : 1.0,
          child: FloatingActionButton(
            onPressed: _toggleListening,
            backgroundColor: _isListening
                ? theme.colorScheme.error
                : theme.colorScheme.tertiary,
            child: _isListening
                ? CustomIconWidget(
                    iconName: 'stop',
                    color: theme.colorScheme.onError,
                    size: 7.w,
                  )
                : CustomIconWidget(
                    iconName: 'mic',
                    color: theme.colorScheme.onTertiary,
                    size: 7.w,
                  ),
          ),
        );
      },
    );
  }
}
