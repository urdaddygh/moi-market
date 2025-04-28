import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';

class ShowPhotoDialog extends StatelessWidget {
  const ShowPhotoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            color: Colors.black.withValues(alpha: 0), // Нужно для срабатывания BackdropFilter
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100, right: Style.defaultSpacing, left: Style.defaultSpacing, top: 50),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: Style.dialogShadows,
              color: Style.primaryWhiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Style.defaultSplashRadius),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Style.defaultPaddingVertical),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Style.middleSpacing, left: Style.middleSpacing * 4),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text('Добавить чек', style: Style.titleText),
                            ),
                          ),
                          IconButton(
                              onPressed: () => {Navigator.pop(context), BlocProvider.of<HomeCubit>(context).flushAttachment()},
                              icon: const Icon(
                                Icons.clear,
                                color: Style.hintTextColor,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: Style.largeSpacing),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: 400,
                          color: Style.primaryBlackColor.withValues(alpha: 0.1),
                          child: state.attachment != null
                              ? Image.file(File(state.attachment!.path))
                              : Image.asset('assets/images/check.png'),
                        );
                      },
                    ),
                    const SizedBox(height: Style.defaultPaddingVertical),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Style.bigSpacing),
                      child: Column(
                        children: [
                          DefaultElevatedButton(
                              text: 'Добавить',
                              onPressed: () => BlocProvider.of<HomeCubit>(context).choosePhoto(context, ImageSource.camera)),
                          const SizedBox(height: Style.middleSpacing + 2),
                          DefaultElevatedButton(
                            text: 'Добавить из галереи',
                            onPressed: () => BlocProvider.of<HomeCubit>(context).choosePhoto(context, ImageSource.gallery),
                            color: Style.primaryWhiteColor,
                            textColor: Style.primaryColor,
                            side: const BorderSide(
                              width: 1.5,
                              color: Style.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
