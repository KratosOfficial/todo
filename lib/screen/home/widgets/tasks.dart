import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:todo/screen/details/detail.dart';

class Tasks extends StatelessWidget {
  final tasksList = Task.generateTasks();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
          itemCount: tasksList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => tasksList[index].islast
              ? _buildAddtask()
              : _buildTask(context, tasksList[index])),
    );
  }

  Widget _buildAddtask() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(20),
      dashPattern: [10,10],
      color: Colors.grey,
      strokeWidth: 2,
      child: Center(
        child: Text(
          "+ Add",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> detailpage( task: task,)));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: task.bgcolor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.iconData,
              color: task.iconcolor,
              size: 35,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              task.title!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTaskStatus(
                    task.btncolor!, task.iconcolor!, '${task.left} left'),
                SizedBox(
                  width: 5,
                ),
                _buildTaskStatus(
                    Colors.white, task.iconcolor!, '${task.done} done')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgcolor, Color txcolor, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: txcolor)),
    );
  }
}
