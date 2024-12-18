import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/download_cubit.dart';

class BookListPageTest extends StatelessWidget {
  const BookListPageTest({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {
        "name": "amr",
        "url":
            "https://firebasestorage.googleapis.com/v0/b/nursery-2d2dc.firebasestorage.app/o/dayone.pdf?alt=media&token=34771369-7204-46ef-abbb-0e70a6422314"
      },
      {
        "name": "shereen",
        "url":
            "https://firebasestorage.googleapis.com/v0/b/nursery-2d2dc.firebasestorage.app/o/birthdate.pdf?alt=media&token=00721eb3-6732-45a9-b65c-abed5591e132"
      },
    ];

    return Scaffold(
      body: BlocListener<DownloadCubit, DownloadState>(
        listener: (context, state) {
          // Listen for the DownloadSuccess state and show SnackBar
          if (state is DownloadSuccess) {
            // After the build, show the snackbar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Download complete!'),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
        },
        child: BlocBuilder<DownloadCubit, DownloadState>(
          builder: (context, state) {
            var models = DownloadCubit.get(context).downloadModel;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final url = book["url"] ?? "";
                final name =
                    book["name"]?.replaceAll(' ', '_') ?? "unknown.pdf";

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(book["name"] ?? "",
                          style: const TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DownloadCubit>().startDownload(url, name);
                      },
                      child: state is DownloadLoading
                          ? const CircularProgressIndicator() // Show progress indicator during loading
                          : const Text("Download"),
                    ),
                    // Show error message if download failed
                    if (state is DownloadError) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Error: ${state.errorMessage}',
                            style: const TextStyle(color: Colors.red)),
                      ),
                    ],
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
