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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowPhotoDialog extends StatelessWidget {
  const ShowPhotoDialog({super.key, this.imageLink});

  final String? imageLink;

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
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: Style.middleSpacing, left: Style.middleSpacing * 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(AppLocalizations.of(context)!.addReceipt, style: Style.titleText),
                                ),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      {Navigator.pop(context), BlocProvider.of<HomeCubit>(context).flushAttachment()},
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Style.hintTextColor,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: Style.largeSpacing),
                        Container(
                          width: double.infinity,
                          height: 400,
                          color: Style.primaryBlackColor.withValues(alpha: 0.1),
                          child: Stack(
                            children: [
                              Center(
                                child: state.attachment != null
                                    ? Image.file(File(state.attachment!.path))
                                    : imageLink != null
                                        ? Image.network(imageLink!)
                                        : Image.asset('assets/images/no_image.png'),
                              ),
                              if (state.attachment != null)
                                Positioned(
                                  top: 20,
                                  right: 5,
                                  child: IconButton(
                                    onPressed: () => BlocProvider.of<HomeCubit>(context).flushAttachment(),
                                    icon: const Icon(
                                      size: 30,
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Style.defaultPaddingVertical),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Style.bigSpacing),
                          child: Column(
                            children: [
                              DefaultElevatedButton(
                                text: AppLocalizations.of(context)!.add,
                                onPressed: () => state.attachment != null
                                    ? BlocProvider.of<HomeCubit>(context)
                                        .addReceipt(context: context, ticket: 0, schedule: 0)
                                    : BlocProvider.of<HomeCubit>(context).choosePhoto(context, ImageSource.camera),
                              ),
                              const SizedBox(height: Style.middleSpacing + 2),
                              DefaultElevatedButton(
                                text: AppLocalizations.of(context)!.addInGallery,
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
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
