import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_database_bloc/bloc.dart';
import 'package:todo_app_with_new_version_bloc/custom_icon/my_flutter_app_icons.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model_for_data_base.dart';
import 'package:todo_app_with_new_version_bloc/screen/from_data_base/all_task_from_data_base_page.dart';
import 'package:todo_app_with_new_version_bloc/utils/dimensions.dart';
import '../../bloc/task_from_database_bloc/event.dart';

class ReadTaskFromDataBasePage extends StatefulWidget {

  TaskForDataBaseModel? task;
  bool? isChecked;

  ReadTaskFromDataBasePage({Key? key, this.task, this.isChecked}): super(key: key);

  @override
  State<ReadTaskFromDataBasePage> createState() => _ReadTaskFromDataBasePageState(task, isChecked);
}

class _ReadTaskFromDataBasePageState extends State<ReadTaskFromDataBasePage> {

  TaskForDataBaseModel? task;
  bool? isChecked;

  _ReadTaskFromDataBasePageState(this.task, this.isChecked);

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
                      value: task!.done == "true" ? true : false,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                          task!.done = isChecked.toString();
                          final createTask =
                          BlocProvider.of<TaskFromDataBaseBloc>(context);
                          createTask.add(EditTaskEvent(
                              taskForDataBaseModel: task!
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
