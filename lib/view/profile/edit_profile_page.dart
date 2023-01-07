import 'package:flutter/material.dart';
import 'package:here/model/user.dart';
import 'package:kartal/kartal.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _student_noController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user?.name ?? "";
    _surnameController.text = widget.user?.surname ?? "";
    _mailController.text = widget.user?.mail ?? "";
    _student_noController.text = widget.user?.student_no ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: context.width / 5.0),
          child: const Text("Edit Profile"),
        ),
        actions: [
          _loading
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 103, 80, 164),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: context.width / 3.0,
                  height: context.height / 4.0,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 234, 221, 255),
                    child: Text(
                      "${widget.user?.name?[0].toCapitalized() ?? ""}${widget.user?.surname?[0].toCapitalized() ?? ""}",
                      style: context.textTheme.displayMedium!.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Padding(padding: EdgeInsets.only(top: 20), child: Icon(Icons.person)),
                title: Text(
                  "First Name",
                  style: context.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
                subtitle: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  autocorrect: true,
                  validator: (String? data) {
                    if (data.isNullOrEmpty || !(RegExp('[a-zA-Z]').hasMatch(data!))) return "*";
                    return null;
                  },
                ),
                trailing: const SizedBox(),
              ),
              ListTile(
                leading: const Padding(padding: EdgeInsets.only(top: 20), child: Icon(Icons.person)),
                title: Text(
                  "Last Name",
                  style: context.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
                subtitle: TextFormField(
                  controller: _surnameController,
                  keyboardType: TextInputType.text,
                  autocorrect: true,
                  validator: (String? data) {
                    if (data.isNullOrEmpty || !(RegExp('[a-zA-Z]').hasMatch(data!))) return "*";
                    return null;
                  },
                ),
                trailing: const SizedBox(),
              ),
              ListTile(
                leading: const Padding(padding: EdgeInsets.only(top: 20), child: Icon(Icons.mail)),
                title: Text(
                  "Email",
                  style: context.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
                subtitle: TextFormField(
                  controller: _mailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: true,
                  validator: (String? data) {
                    if (!(data.isValidEmail)) return "Geçersiz email";
                    return null;
                  },
                ),
                trailing: const SizedBox(),
              ),
              ListTile(
                leading: const Padding(padding: EdgeInsets.only(top: 20), child: Icon(Icons.school)),
                title: Text(
                  "School Number",
                  style: context.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
                subtitle: TextFormField(
                  controller: _student_noController,
                  keyboardType: TextInputType.number,
                  autocorrect: true,
                  validator: (String? data) {
                    return data!.isEmpty ? "*" : (RegExp(r'\d').hasMatch(data) ? null : "Geçersiz numara");
                  },
                ),
                trailing: const SizedBox(),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              SizedBox(
                width: context.width * 0.7,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _changeLoading();
                      // request
                      _changeLoading();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 103, 80, 164),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                  child: Text(
                    "Update",
                    style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLoading() {
    setState(() {
      _loading = !_loading;
    });
  }
}
