import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/home_layout/cubit/cubit.dart';

import '../../../layouts/home_layout/cubit/states.dart';
import '../../../shared/widgets/widgets.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:
                HomeCubit.get(context).unionModel.data.services.isNotEmpty,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      buildNewsItem(
                        HomeCubit.get(context).unionModel.data.information,
                        HomeCubit.get(context)
                            .unionModel
                            .data
                            .information
                            .length,
                        context,
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }
}
