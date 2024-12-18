import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../manager/download_cubit.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadCubit, DownloadState>(
      listener: (context, state) {
        // Listen for the DownloadSuccess state and show SnackBar
        if (state is DownloadSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Download complete!'),
                backgroundColor: Colors.green,
              ),
            );
          });
        } else if (state is DownloadError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      },
      builder: (context, state) {
        var models = DownloadCubit.get(context).downloadModel;

        return Stack(
          children: [
            ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: models.length,
              itemBuilder: (context, index) {
                var model = models[index];
                final url = model.url ?? "";
                final category = model.category ?? "";
                final name = model.name?.replaceAll(' ', '_') ?? "unknown.pdf";

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.grey[300],
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Download",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: const Icon(
                                            Icons.warning_amber_outlined),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Text(
                                            "You are about to download $name",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[100],
                                        textStyle: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<DownloadCubit>()
                                            .startDownload(url, name);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        textStyle: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 120.h,
                          width: 120.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.white,
                                  Colors.grey[200]!
                                ]),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.bookmark,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        category,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )),
                              Divider(
                                height: 2,
                                color: Colors.grey[300],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 11),
                                child: Text(model.name ?? "",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w800)),
                              ),
                              Spacer(),
                              Divider(
                                height: 2,
                                color: Colors.grey[300],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 5, right: 7, left: 7),
                                child: Row(
                                  children: [
                                    Text("Download"),
                                    Spacer(),
                                    Icon(
                                      Icons.download_for_offline,
                                      color: Colors.blue[300],
                                      size: 28,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (state is DownloadError) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Error: ${state.errorMessage}',
                              style: const TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
            if (state is DownloadLoading) ...[
              Container(
                child: Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  right: 20.w,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: state.progress,
                        color: Colors.red,
                        minHeight: 20,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${(state.progress * 100).toStringAsFixed(1)}%',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
