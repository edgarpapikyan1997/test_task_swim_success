import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/pace_cubit.dart';
import '../../logic/pace_state.dart';
import '../widgets/pace_time_display.dart';

class PaceSelectorScreen extends StatelessWidget {
  const PaceSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaceCubit(),
      child: const _PaceSelectorView(),
    );
  }
}

class _PaceSelectorView extends StatelessWidget {
  const _PaceSelectorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PaceCubit, PaceState>(
          builder: (context, state) {
            final input = state as PaceInputState;
            final cubit = context.read<PaceCubit>();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Text('YOUR PACE', style: AppTextStyles.label),
                  const SizedBox(height: AppSpacing.lg),
                  PaceTimeDisplay(
                    minutes: input.minutes,
                    seconds: input.seconds,
                    onMinutesChanged: cubit.setMinutes,
                    onSecondsChanged: cubit.setSeconds,
                    onIncrementMinutes: cubit.incrementMinutes,
                    onDecrementMinutes: cubit.decrementMinutes,
                    onIncrementSeconds: cubit.incrementSeconds,
                    onDecrementSeconds: cubit.decrementSeconds,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('MIN : SEC / 100M', style: AppTextStyles.caption),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
