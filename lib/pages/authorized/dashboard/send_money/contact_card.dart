import 'package:flutter/material.dart';
class ContactCard extends StatelessWidget {
   ContactCard({Key? key, this.contact_image, this.contact_name}) : super(key: key);

  String? contact_image;
  String? contact_name;

  @override
  Widget build(BuildContext context) {
    var contact_name = this.contact_name ??= "Add";
    var contact_image = this.contact_image != null ? const Icon(Icons.person) : const Icon(Icons.add);
    return 
                Container(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: contact_image,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        contact_name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Signika'
                        ),
                      ),
                    ],
                  ),
                );
  }
}