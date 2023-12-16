import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';
import 'package:safri/widgets/item_shared/default_button.dart';
import 'package:safri/widgets/item_shared/defult_form.dart';
import 'package:safri/widgets/item_shared/phone_form.dart';

import '../../cubit/menu_cubit.dart';
import '../../cubit/menu_states.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    if(cubit.userModel!=null){
      nameC.text = cubit.userModel!.data!.name??'';
      emailC.text = cubit.userModel!.data!.email??'';
      phoneC.text = cubit.userModel!.data!.phoneNumber??'';
    }
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {
        if(state is UpdateProfileSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        return Scaffold(
          body: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              children: [
                DefaultAppBar(tr('profile_info')),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultForm(
                          hint: tr('full_name'),
                          controller: nameC,
                          validator: (str){
                            if(str.isEmpty)return tr('name_empty');
                          },
                          prefix: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(Images.user, width: 10,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: DefaultForm(
                            controller: emailC,
                            hint: tr('email_address'),
                            validator: (str){
                              if(str.isEmpty)return tr('email_empty');
                              if(!str.contains('.'))return tr('email_invalid');
                              if(!str.contains('@'))return tr('email_invalid');
                            },
                            type: TextInputType.emailAddress,
                            prefix: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(Images.mail, width: 10,),
                            ),
                          ),
                        ),
                        PhoneForm(
                          readOnly: true,
                            controller: phoneC,
                          validator: (str){
                            if(str.isEmpty)return tr('phone_empty');
                          },
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! UpdateProfileLoadingState,
                          fallback: (c)=>const Center(child: CupertinoActivityIndicator(),),
                          builder: (c)=> DefaultButton(
                              text: tr('save_info'),
                              onTap: () {
                                if(formKey.currentState!.validate()){
                                  cubit.updateProfile(
                                    email: emailC.text,
                                    phone: phoneC.text,
                                    name: nameC.text,
                                  );
                                }
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
