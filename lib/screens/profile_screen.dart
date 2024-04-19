import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/database/cache/cache_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit/user_cubit.dart';

import '../core/api/end_point.dart';
import '../cubit/user_cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is UserLoading
              ? const Center(child: CircularProgressIndicator())
              : state is UserSuccess
                 ? ListView(
                      children: [
                        const SizedBox(height: 16),
                        //! Profile Picture
                        CircleAvatar(
                          radius: 80,

                          backgroundImage: NetworkImage(
                            state.user.user!.profilePic!,
                          ),
                        ),
                        const SizedBox(height: 16),

                        //! Name
                         ListTile(
                          title: Text(state.user.user!.name!),
                          leading: const Icon(Icons.person),
                        ),
                        const SizedBox(height: 16),

                        //! Email
                         ListTile(
                          title: Text(state.user.user!.email!),
                          leading: Icon(Icons.email),
                        ),
                        const SizedBox(height: 16),

                        //! Phone number
                         ListTile(
                          title: Text(state.user.user!.phone!),
                          leading: Icon(Icons.phone),
                        ),
                        const SizedBox(height: 16),

                        //! Address
                         ListTile(
                          title: Text("Cairo, Egypt"),
                          leading: Icon(Icons.location_city),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
        : Container(),
        );
      },
    );
  }
}
