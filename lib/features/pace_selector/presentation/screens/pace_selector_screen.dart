import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_messages.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../user_list/presentation/screens/user_list_screen.dart';
import '../../data/repository/pace_repository_impl.dart';
import '../../logic/pace_cubit.dart';
import '../../logic/pace_state.dart';
import '../theme/swimmer_level_colors.dart';
import '../widgets/pace_app_bar.dart';
import '../widgets/pace_continue_button.dart';
import '../widgets/pace_level_display.dart';
import '../widgets/pace_level_tabs.dart';
import '../widgets/pace_progress_bar.dart';
import '../widgets/pace_screen_header.dart';
import '../widgets/pace_skip_link.dart';
import '../widgets/pace_slider.dart';
import '../widgets/pace_time_display.dart';

class PaceSelectorScreen extends StatelessWidget {
  const PaceSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaceCubit(PaceRepositoryImpl()),
      child: const _PaceSelectorView(),
    );
  }
}

class _PaceSelectorView extends StatefulWidget {
  const _PaceSelectorView();

  @override
  State<_PaceSelectorView> createState() => _PaceSelectorViewState();
}

class _PaceSelectorViewState extends State<_PaceSelectorView> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaceCubit, PaceState>(
      listenWhen: (previous, current) =>
          current is PaceSubmitSuccess || current is PaceSubmitError,
      listener: (context, state) {
        if (state is PaceSubmitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppMessages.paceSaved)),
          );
        }
        if (state is PaceSubmitError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () => context.read<PaceCubit>().submitPace(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<PaceCubit>();
        final isSubmitting = state is PaceSubmitting;
        final accent = SwimmerLevelColors.accentFor(state.swimmerLevel);

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AppBackground(
            child: SafeArea(
              child: Column(
                children: [
                  const PaceAppBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.sm),
                          const PaceProgressBar(),
                  const SizedBox(height: AppSpacing.xl),
                  const PaceScreenHeader(),
                  const SizedBox(height: AppSpacing.xl),
                  Text('YOUR PACE', style: AppTextStyles.label),
                  const SizedBox(height: AppSpacing.lg),
                  AbsorbPointer(
                    absorbing: isSubmitting,
                    child: Column(
                      children: [
                        PaceTimeDisplay(
                          minutes: state.minutes,
                          seconds: state.seconds,
                          onMinutesChanged: cubit.setMinutes,
                          onSecondsChanged: cubit.setSeconds,
                          onIncrementMinutes: cubit.incrementMinutes,
                          onDecrementMinutes: cubit.decrementMinutes,
                          onIncrementSeconds: cubit.incrementSeconds,
                          onDecrementSeconds: cubit.decrementSeconds,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('MIN : SEC / 100M', style: AppTextStyles.caption),
                        const SizedBox(height: AppSpacing.xl),
                        PaceLevelDisplay(level: state.swimmerLevel),
                        const SizedBox(height: AppSpacing.lg),
                        PaceLevelTabs(activeLevel: state.swimmerLevel),
                        const SizedBox(height: AppSpacing.lg),
                        PaceSlider(
                          totalSeconds: state.totalSecondsValue,
                          accentColor: accent,
                          onChanged: cubit.setTotalSeconds,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PaceContinueButton(
                    level: state.swimmerLevel,
                    isLoading: isSubmitting,
                    isEnabled: !isSubmitting,
                    onPressed: cubit.submitPace,
                  ),
                  PaceSkipLink(
                    onPressed: isSubmitting || _isNavigating
                        ? null
                        : _skipPace,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _skipPace() async {
    if (_isNavigating) {
      return;
    }
    setState(() => _isNavigating = true);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const UserListScreen()),
    );
    if (mounted) {
      setState(() => _isNavigating = false);
    }
  }
}
