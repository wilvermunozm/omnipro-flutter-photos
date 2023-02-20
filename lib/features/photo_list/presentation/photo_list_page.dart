import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnipro/core/app/presentation/widgets/custom_error_widget.dart';
import 'package:omnipro/core/app/presentation/widgets/loader_wiget.dart';

import 'bloc/photo_bloc.dart';
import 'bloc/photo_event.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({Key? key}) : super(key: key);

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Photo List"),
        ),
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
              return _buildPhotoList(state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildPhotoList(Loaded state) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: state.photoListInView.length + 1,
      itemBuilder: (_, index) {
        if (index == state.photoListInView.length) {
          return const LoaderWidget();
        }

        final photo = state.photoListInView[index];
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

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<PhotoBloc>().add(const MoreResultsEvent());
    }
  }
}
