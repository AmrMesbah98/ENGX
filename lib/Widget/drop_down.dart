import 'package:asec_application/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Courses'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(

                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class MultiDrop extends StatefulWidget {
  const MultiDrop({Key? key}) : super(key: key);

  @override
  State<MultiDrop> createState() => _MultiDropState();
}

class _MultiDropState extends State<MultiDrop> {
  List<String> selectedItems = [];



  void _showMultiSelect() async {

    final List<String> items = [
      'Flutter',
      'Node.js',
      'React Native',
      'Java',
      'Docker',
      'Web',
      'Front',
      'Back',
    ];
    final List<String> itemskahraba = [
      'AutoCAD',
      'Revit',
      'Dynamo',
      'Enscape',
      'Technical Office',
      'TowinMotion',
      'Site Engineering',
      'API',
      'Coordination',
      'KNX',
      'BMS',
      'SCADA',
      'Matlab',
      'Dulux',
      'EtapAnylsis',
      'Matlab',
    ];

    final List<String> itemsmadany = [
      'AutoCAD',
      'Revit',
      'Dynamo',
      'Enscape',
      'Site Engineering',
      'Technical Office',
      'TowinMotion',
      'API',
      'Coordination',
      'CSI Column',
      'SAP2000',
      'Matlab',
      'OSHA',
      'Site Engineer',
      'Primavera',
      'ETaps',
    ];

    final List<String> itemsemara = [
      'AutoCAD',
      'Revit',
      'Dynamo',
      'Enscape',
      'Technical Office',
      'TowinMotion',
      'API',
      'Coordination',
      '3D Max',
      'Lumion',
      'PhotoShop',
      'VRAR',
      'Interrior Design',
      'Urban Design',
      'Indesign',
      'Indesign',
      'Site Engineering',
    ];



    final List<String> itemsmecanica = [
      'AutoCAD',
      'Revit',
      'Dynamo',
      'Enscape',
      'Technical Office',
      'TowinMotion',
      'Site Engineering',
      'API',
      'Coordination',
      'HVAC Design',
      'FireFighting Design',
      'Plumbing Design',
      'Medical Gas Design',
      'NavisWork',
      'Medical Design',
      'Ansys',
    ];




    choose (List <String> trackSelect)
    {

      if(constantvar.track[0] == constantvar.selectTrack)
        {
          return  MultiSelect(
              items: itemsmecanica
          );
        }
      else if(constantvar.track[1] == constantvar.selectTrack)
        {
          return  MultiSelect(
              items: itemskahraba
          );
        }
      else if(constantvar.track[2] == constantvar.selectTrack)
      {
        return  MultiSelect(
            items: itemsmadany
        );
      }
      else
        {
          return  MultiSelect(
              items: itemsemara

          );
        }

    }



    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {

        return  choose(constantvar.track);

      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedItems = results;
        print(selectedItems);
        constantvar.selectedItem = selectedItems;
        print("selectedItem ---------->>>>>>  ${constantvar.selectedItem}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // use this button to open the multi-select dialog

          GestureDetector(
            onTap: _showMultiSelect,
            child: Container(
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.width * .1,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child: Text("select Your Courses",style: TextStyle(fontSize: 16.sp),)) ,
                  const Icon(Icons.search_off_outlined)
                ],
              )
            ),
          ),
          

          // display selected items
          Wrap(
          spacing: 5,
            children: selectedItems
                .map(
                  (e) => Chip(
                    backgroundColor: Colors.grey[100],
                    label: Text(e),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
