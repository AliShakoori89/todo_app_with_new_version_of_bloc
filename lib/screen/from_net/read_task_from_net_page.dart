import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_net_bloc/bloc.dart';
import 'package:todo_app_with_new_version_bloc/custom_icon/my_flutter_app_icons.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model.dart';
import 'package:todo_app_with_new_version_bloc/utils/dimensions.dart';
import '../../bloc/task_from_net_bloc/event.dart';
import 'all_task_from_net_page.dart';

class ReadTaskFromNetPage extends StatefulWidget {

  TaskModel? task;
  bool? isChecked;

  ReadTaskFromNetPage({Key? key, this.task, this.isChecked}): super(key: key);

  @override
  State<ReadTaskFromNetPage> createState() => _ReadTaskFromNetPageState(task, isChecked);
}

class _ReadTaskFromNetPageState extends State<ReadTaskFromNetPage> {

  TaskModel? task;
  bool? isChecked;

  _ReadTaskFromNetPageState(this.task, this.isChecked);

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.black;
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              right: Dimensions.paddingWith_10,
              left: Dimensions.paddingWith_10,
              top: Dimensions.paddingHeight_20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: Icon(MyFlutterApp.arrow_left_circle,
                        size: Dimensions.iconSmallSize,)),
                  Text('${task!.title}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: Dimensions.fontLargeSize
                    ),)
                ],
              ),
              SizedBox(height: Dimensions.paddingHeight_20,),
              Container(
                margin: EdgeInsets.only(
                    right: Dimensions.paddingWith_10,
                    left: Dimensions.paddingWith_10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.smallRadius),
                ),
                child: Container(
                  width: double.infinity,
                  height: Dimensions.descriptionDetailBoxSize,
                  margin: EdgeInsets.only(
                    top: Dimensions.paddingHeight_10,
                    right: Dimensions.paddingWith_10,
                    left: Dimensions.paddingWith_10,
                    bottom: Dimensions.paddingHeight_10
                  ),
                  child: Text("${task!.description}",
                  style: const TextStyle(
                    color: Color.fromRGBO(130, 130, 130, 1)
                    )
                  ),
                ),
              ),
              SizedBox(height: Dimensions.paddingHeight_20,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.smallRadius)),
                margin: EdgeInsets.only(
                    right: Dimensions.paddingWith_10,
                    left: Dimensions.paddingWith_10,
                    top: Dimensions.paddingHeight_20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.paddingWith_10,),
                      child: Text(
                        "Have You Done This Task?",
                        style: TextStyle(
                            color: const Color.fromRGBO(22, 190, 105, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: Dimensions.fontVerySmallSize),
                      ),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: task!.done,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                          task!.done = isChecked;
                          BlocProvider.of<TaskFromNetBloc>(context).add(EditTaskEvent(
                              taskModel: task!
                          ));
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
