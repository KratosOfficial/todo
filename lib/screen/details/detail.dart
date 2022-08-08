import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screen/details/widgets/DatePicker.dart';
import 'package:todo/screen/details/widgets/task_title.dart';

import 'widgets/tasktimeline.dart';

class detailpage extends StatelessWidget {
  final Task task;

  const detailpage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailList = task.desc;
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DatePicker(),
                    tasktitle(),
                  ],
                ),
              ),
            ),
            detailList == null
                ? SliverFillRemaining(
                    child: Container(
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          "No task Today",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ))),
                  ) :
            SliverList(delegate: SliverChildBuilderDelegate(
                  (_, index) => TaskTimeline(detailList[index]),
              childCount: detailList.length),
              ),
          ],
        ));
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 20,
      ),
      actions: [
        Icon(
          Icons.more_vert,
          size: 40,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.title} tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "You Have ${task.left} new tasks for today!",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
