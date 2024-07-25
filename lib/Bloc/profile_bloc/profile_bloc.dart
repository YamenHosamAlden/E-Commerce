import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/profile_model.dart';
import 'package:ecommerce/Data/Repository/profile_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository = ProfileRepository();
  ProfileModel? profileModel;

  TextEditingController fisrtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  File? fileImage;

  DateTime? birthDate;

  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(GetProfileLoadingState());

      ApiResult apiResult = await profileRepository.getProfile();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        profileModel = ProfileModel.fromJson(apiResult.response!.data);

        fisrtNameController = TextEditingController(
            text: profileModel!.customer!.user!.firstName);
        lastNameController =
            TextEditingController(text: profileModel!.customer!.user!.lastName);
        emailController =
            TextEditingController(text: profileModel!.customer!.user!.email);
        phoneController =
            TextEditingController(text: profileModel!.customer!.phoneNumber);
        usernameController =
            TextEditingController(text: profileModel!.customer!.user!.username);

        emit(GetProfileSuccessfulState());
      } else {
        emit(GetProfileErrorState(message: apiResult.error));
      }
    });

    on<EditProfileEvent>((event, emit) async {
      emit(EditProfileLoadingState());
      Customer userProfile = Customer(
        user: User(
            firstName: fisrtNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            username: usernameController.text),
        phoneNumber: phoneController.text,
        fileImage: fileImage,
      );

      ApiResult apiResult =
          await profileRepository.editProfile(userProfile: userProfile);
      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        emit(EditProfileSuccessfulState());
      } else {
        emit(EditProfileErrorState(message: apiResult.error));
      }
    });

    // on<ChangePasswordEvent>((event, emit) async {
    //   emit(ChangePasswordLoadingState());
    //   ApiResult apiResult = await profileRepository.changePassword(
    //       oldPassword: event.oldPassword,
    //       newPassword: event.newPassword,
    //       confirmPassword: event.confirmPassword);
    //   if (apiResult.response != null && apiResult.response!.statusCode == 200) {
    //     emit(ChangePasswordSuccessfulState());
    //   } else {
    //     emit(ChangePasswordErrorState(message: apiResult.error));
    //   }
    // });
  }
}
