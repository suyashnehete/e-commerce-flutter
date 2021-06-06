import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:e_commerce/widgets/address_tile.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FutureBuilder<List<AddressModel>>(
              future: API.getUserAddresses(context),
              builder: (context, list) {
                if (list.hasData) {
                  if (list.data.length == 0) {
                    return Center(
                      child: Text(
                        Strings.NO_Address,
                        style: homeTextStyle,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(20.sp),
                    itemCount: list.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: AddressTile(
                          model: list.data[index],
                          onEdit: (val) {
                            if (val) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(Strings.ADDRESS_UPDATED)));
                              setState(() {});
                            }
                          },
                          onDelete: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(Strings.ADDRESS_DELETED)));
                            setState(() {});
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              var dialog = await showDialog(
                context: context,
                builder: (context) => AddressDialog(
                  model: AddressModel(
                    pin: "",
                    phone: "",
                    address: "",
                    name: "",
                    id: 0,
                  ),
                ),
              );
              if (dialog != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(Strings.ADDRESS_ADDED)));
                setState(() {});
              }
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.all(10.sp),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            child: Text(
              Strings.ADD_ADDRESS,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
