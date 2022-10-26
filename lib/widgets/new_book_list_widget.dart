import 'package:flutter/material.dart';
import 'package:flutter_audio_book/views/audio_play_screen.dart';

import '../utils/utils.dart';

class NewBookListWidget extends StatelessWidget {
  final List bookList;

  const NewBookListWidget({
    Key? key,
    required this.bookList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bookList.isEmpty ? 0 : bookList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 10,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AudioPlayScreen(
                    audioTitle: bookList[index]['title'],
                    author: bookList[index]['author'],
                    imageLink: bookList[index]['image'],
                    audioSource: bookList[index]['audio'],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.tabBarViewColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 80,
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 2,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            bookList[index]['image'],
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.starColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              bookList[index]['rating'],
                              style: const TextStyle(
                                color: AppColors.menu2Color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          bookList[index]['title'].toString().toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          bookList[index]['author'].toString(),
                          style: const TextStyle(
                            color: AppColors.subTitleColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 240,
                          child: Text(
                            bookList[index]['description'].toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.subTitleColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.loveColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            bookList[index]['category'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
