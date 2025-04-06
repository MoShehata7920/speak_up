import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:speak_up/core/widgets/app_text.dart';
import 'package:speak_up/core/resources/assets_manager.dart';
import 'package:speak_up/core/resources/strings_manager.dart';
import 'package:speak_up/core/resources/utils.dart';
import 'package:speak_up/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:speak_up/features/settings/presentation/cubit/settings_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsCubit>().state;
    _nameController.text = state.fullName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: AppStrings.editProfile.tr(),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            _profileImage != null
                                ? FileImage(_profileImage!)
                                : state.profileImage != null &&
                                    state.profileImage!.isNotEmpty
                                ? MemoryImage(base64Decode(state.profileImage!))
                                : AssetImage(AppImages.profilePlaceholder)
                                    as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                AppText(
                  text: AppStrings.tapToChangePhoto.tr(),
                  color: Colors.grey,
                ),
                SizedBox(height: size.height * 0.04),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppStrings.fullName.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text(AppStrings.save.tr()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final cubit = context.read<SettingsCubit>();
    String? base64Image;
    if (_profileImage != null) {
      final bytes = await _profileImage!.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    try {
      await cubit.updateProfile(
        fullName: _nameController.text.trim(),
        profileImage: base64Image,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.profileUpdated.tr())));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
