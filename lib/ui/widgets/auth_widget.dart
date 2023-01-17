import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/auth_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: const [
          SizedBox(
            height: 20,
          ),
          Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
            style: textStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "If you signed up but didn't get your verification email, to have it resent.",
            style: textStyle,
          ),
          SizedBox(
            height: 20,
          ),
          _ErrorMessageWidget(),
          _FormWidget()
        ]),
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final decorationInput = const InputDecoration(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffced4da), width: 1.0),
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)
  );

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('user name', style: TextStyle(fontSize: 16),),
        const SizedBox(height: 5,),
        TextField(decoration: decorationInput, controller: model?.loginTextController,),
        const SizedBox(height: 20,),
        const Text('Password', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5,),
        TextField(decoration: decorationInput, obscureText: true, controller: model?.passwordTextController),
        const SizedBox(height: 30,),
        Row(children: [
        const _AuthButtonWidget(),
          const SizedBox(width: 10,),
          TextButton(onPressed: () {
          }, child: const Text('reset password'))
        ],)
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed = model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true ?
    const SizedBox(width: 15, height: 15,child: CircularProgressIndicator(strokeWidth: 2,),) :
    const Text('Login');

    return ElevatedButton(
    onPressed: onPressed,
      child: child
      );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthModel>(context)?.errorMessage;

    if(errorMessage == null) return const SizedBox.shrink();
    return Text(
      errorMessage,
      style: const TextStyle(fontSize: 17, color: Colors.red),
    );
  }
}


