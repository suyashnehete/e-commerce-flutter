import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddressTile extends StatelessWidget {
  final AddressModel model;
  final Function(bool) onEdit;
  final Function onDelete;
  AddressTile({this.model, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(model.id),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 30.sp,
            ),
            Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 30.sp,
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        API.deleteUserAddresses(model.id);
        onDelete();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    model.phone,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    model.address,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    model.pin,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      var dialog = await showDialog(
                        context: context,
                        builder: (context) => AddressDialog(
                          model: model,
                        ),
                      );
                      onEdit(dialog != null);
                    },
                    child: Text(
                      Strings.EDIT,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(10.sp),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.sp),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.sp,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      API.deleteUserAddresses(model.id);
                      onDelete();
                    },
                    child: Text(
                      Strings.DELETE,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(10.sp),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.sp),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddressDialog extends StatelessWidget {
  final AddressModel model;

  AddressDialog({this.model});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: model.name);
    TextEditingController phoneController =
        TextEditingController(text: model.phone);
    TextEditingController addressController =
        TextEditingController(text: model.address);
    TextEditingController pinController =
        TextEditingController(text: model.pin);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 35.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15.sp),
              ),
            ),
            padding: EdgeInsets.only(
              top: 50.sp,
              left: 20.sp,
              right: 20.sp,
              bottom: 20.sp,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  style: textFieldStyle,
                  decoration: InputDecoration(
                    hintText: Strings.NAME_HINT,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                TextField(
                  controller: phoneController,
                  style: textFieldStyle,
                  decoration: InputDecoration(
                    hintText: Strings.PHONE_HINT,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                TextField(
                  controller: addressController,
                  style: textFieldStyle,
                  decoration: InputDecoration(
                    hintText: Strings.ADDRESS_HINT,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                TextField(
                  controller: pinController,
                  style: textFieldStyle,
                  decoration: InputDecoration(
                    hintText: Strings.PINCODE,
                    prefixIcon: Icon(
                      Icons.my_location,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (model.id == 0) {
                      API.addUserAddresses(
                          context,
                          nameController.text,
                          addressController.text,
                          pinController.text,
                          phoneController.text);
                    } else {
                      API.updateUserAddresses(
                          context,
                          model.id,
                          nameController.text,
                          addressController.text,
                          pinController.text,
                          phoneController.text);
                    }
                    Navigator.pop(context, true);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(buttonColor),
                  ),
                  child: Text(
                    model.id == 0 ? Strings.ADD : Strings.UPDATE,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          CircleAvatar(
            radius: 35.sp,
            backgroundColor: buttonColor,
            child: Icon(
              Icons.home,
              size: 55.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
