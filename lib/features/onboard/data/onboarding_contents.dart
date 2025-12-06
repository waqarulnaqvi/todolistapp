import 'package:todolistapp/core/constants/static_assets/app_images.dart';
import '../model/onboarding_model.dart';

List<OnboardingModel> onboardingContentsList = [
  OnboardingModel(
    image: AppImages.onBoard1,
    title: 'Stay Organized\nWith Smart Sorting',
    description:
        'Sort notes by due date or creation date.\n'
        'Switch between ascending or descending order\n'
        'to view your tasks the way you prefer.',
  ),
  OnboardingModel(
    image: AppImages.onBoard2,
    title: 'Choose Your\nFavorite View Style',
    description:
        'Toggle between a classic list view or a clean\n'
        'staggered grid layout.\n'
        'Perfect for both minimal and visual note-taking.',
  ),
  OnboardingModel(
    image: AppImages.onBoard3,
    title: 'Focus on What\nMatters First',
    description:
        'Filter notes by priority—Low, Medium, High,\n'
        'or All. Highlight important tasks and stay\n'
        'productive with clear priorities.',
  ),
  OnboardingModel(
    image: AppImages.onBoard4,
    title: 'Manage Notes\nWith Precision',
    description:
        'Set due dates, add details, and keep track of\n'
        'your plans effortlessly.\n'
        'A perfect blend of simplicity and control.',
  ),
];
