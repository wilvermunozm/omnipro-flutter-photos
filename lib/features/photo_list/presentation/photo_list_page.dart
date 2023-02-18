import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnipro/core/app/presentation/widgets/custom_error_widget.dart';
import 'package:omnipro/core/app/presentation/widgets/loader_wiget.dart';

import 'bloc/photo_bloc.dart';
import 'bloc/photo_event.dart';

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is Initial) {
              context.read<PhotoBloc>().add(const GetPhotosEvent());
              return const LoaderWidget();
            }

            if (state is Loading) {
              return const LoaderWidget();
            }

            if (state is Error) {
              return const CustomErrorWidget();
            }

            if (state is Loaded) {
              return ListView.builder(
                itemCount: state.photoList.length,
                itemBuilder: (_, index) {
                  final photo = state.photoList[index];
                  return ListTile(
                    trailing: const Icon(Icons.arrow_drop_down_circle),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photo.thumbnailUrl),
                    ),
                    title: Text(photo.title),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
