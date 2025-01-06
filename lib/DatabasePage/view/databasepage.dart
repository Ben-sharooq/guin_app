import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:guin/constants/constants.dart';

class DatabaseTableScreen extends StatefulWidget {
  @override
  _DatabaseTableScreenState createState() => _DatabaseTableScreenState();
}
 
class _DatabaseTableScreenState extends State<DatabaseTableScreen> {
  String? selectedFilter;
  int groupValue = 0;
 
  List<Map<String, String>> data = [
    {
      'id': '1',
      'name': 'Alakapuzha',
      'projectNo': '364',
      'Yard': 'Y053',
      'Battery': 'Battery 1',
      'Operating Area': 'Kerala',
      'Bbox': 'Bbox1'
    },
    {
      'id': '2',
      'name': 'Chakkittapara 10',
      'projectNo': '297',
      'Yard': 'Y029',
      'Battery': 'Battery 2',
      'Operating Area': 'Kerala',
      'Bbox': 'Bbox1'
    },
    {
      'id': '3',
      'name': 'Chakkittapara 20',
      'projectNo': '298',
      'Yard': 'Y030',
      'Battery': 'Battery 1',
      'Operating Area': 'Kerala',
      'Bbox': 'Bbox1'
    },
    {
      'id': '4',
      'name': 'Canoli Cruise',
      'projectNo': '346',
      'Yard': 'Y038',
      'Battery': 'Battery 1',
      'Operating Area': 'Kerala',
      'Bbox': 'Bbox1'
    },
    {
      'id': '5',
      'name': 'Punjab',
      'projectNo': '298',
      'Yard': 'Y068',
      'Battery': 'Battery 1',
      'Operating Area': 'Kerala',
      'Bbox': 'Bbox1'
    },
  ];
 
  List<Map<String, String>> filteredData = [];
 
  @override
  void initState() {
    super.initState();
    filteredData = data; // Initialize with full data
  }
 
  void applyFilter() {
    setState(() {
      if (selectedFilter == null) {
        filteredData = data;
      } else {
        filteredData =
            data.where((row) => row['name'] == selectedFilter).toList();
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(children: [
              _buildRadioButtons(),
            ]),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildFilterSection(),
                const SizedBox(width: 16),
                _builderButtonSelection(),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            _buildTableHeader(),
            const Divider(),
            Expanded(child: _buildTableContent()),
          ],
        ),
      ),
    );
  }
 
  Widget _buildRadioButtons() {
    return SizedBox(
      width: 500,
      height: 60,
      child: Card(
        color: Colors.transparent,
        elevation: 3,
        surfaceTintColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GFRadio(
                      size: 20,
                      activeBorderColor: GFColors.PRIMARY,
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                      inactiveIcon: null,
                      radioColor: GFColors.PRIMARY),
                  const Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  ),
                  GFRadio(
                    size: 20,
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                    inactiveIcon: null,
                    activeBorderColor: GFColors.PRIMARY,
                    radioColor: GFColors.PRIMARY,
                  ),
                  const Text(
                    'model',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  ),
                  GFRadio(
                    size: 20,
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                    inactiveIcon: null,
                    activeBorderColor: GFColors.PRIMARY,
                    radioColor: GFColors.PRIMARY,
                  ),
                  const Text(
                    'Battery',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  ),
                  GFRadio(
                    size: 20,
                    value: 3,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                    inactiveIcon: null,
                    activeBorderColor: GFColors.PRIMARY,
                    radioColor: GFColors.PRIMARY,
                  ),
                  const Text(
                    'AMC',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _builderButtonSelection() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 60,
      child: Card(
        color: Colors.transparent,
        elevation: 3,
        surfaceTintColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GFButton(
                onPressed: () {},
                text: 'Button',
                textColor: Colors.white,
                shape: GFButtonShape.standard,
              ),
              GFButton(
                onPressed: () {},
                text: 'Button',
                textColor: Colors.white,
                shape: GFButtonShape.standard,
              ),
              GFButton(
                onPressed: () {},
                text: 'Button',
                textColor: Colors.white,
                shape: GFButtonShape.standard,
              ),
              GFButton(
                onPressed: () {},
                text: 'Button',
                textColor: Colors.white,
                shape: GFButtonShape.standard,
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  Widget _buildFilterSection() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Filter by Boats',
            ),
            dropdownColor: cardBackgroundColor,
            value: selectedFilter,
            items: const [
              DropdownMenuItem(
                  value: '1',
                  child: Text(
                    'Alakapuzha',
                    style: TextStyle(color: textColor),
                  )),
              DropdownMenuItem(
                  value: '2',
                  child: Text(
                    'Chakkittapara 10',
                    style: TextStyle(color: textColor),
                  )),
              DropdownMenuItem(
                  value: ' 3',
                  child: Text(
                    'Chakkittapara 20',
                    style: TextStyle(color: textColor),
                  )),
              DropdownMenuItem(
                  value: '4',
                  child: Text(
                    'Punjab',
                    style: TextStyle(color: textColor),
                  )),
              DropdownMenuItem(
                  value: '5',
                  child: Text(
                    'Canoli Cruise',
                    style: TextStyle(color: textColor),
                  )),
            ],
            onChanged: (value) {
              setState(() {
                selectedFilter = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: applyFilter,
          child: const Text('Apply Filter'),
        ),
      ],
    );
  }
 
  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
            flex: 1,
            child: Text('ID',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 2,
            child: Text('Name',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 2,
            child: Text('Project No',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 3,
            child: Text('Yard',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 3,
            child: Text('Battery',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 3,
            child: Text('Operating Area',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 3,
            child: Text('BBox',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
        Expanded(
            flex: 2,
            child: Text('Actions',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor))),
      ],
    );
  }
 
  Widget _buildTableContent() {
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final row = filteredData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    row['id']!,
                    style: TextStyle(color: textColor),
                  )),
              Expanded(
                  flex: 2,
                  child:
                      Text(row['name']!, style: TextStyle(color: textColor))),
              Expanded(
                  flex: 2,
                  child: Text(row['projectNo']!,
                      style: TextStyle(color: textColor))),
              Expanded(
                  flex: 3,
                  child:
                      Text(row['Yard']!, style: TextStyle(color: textColor))),
              Expanded(
                  flex: 3,
                  child: Text(row['Battery']!,
                      style: TextStyle(color: textColor))),
              Expanded(
                  flex: 3,
                  child: Text(row['Operating Area']!,
                      style: TextStyle(color: textColor))),
              Expanded(
                  flex: 3,
                  child:
                      Text(row['Bbox']!, style: TextStyle(color: textColor))),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: textColor,
                      ),
                      onPressed: () {
                        // Handle edit action
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: textColor,
                      ),
                      onPressed: () {
                        // Handle delete action
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
 