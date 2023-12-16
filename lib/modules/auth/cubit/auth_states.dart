abstract class AuthStates{}

class AuthInitState extends AuthStates{}

class EmitState extends AuthStates{}

class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginWrongState extends AuthStates{}
class LoginErrorState extends AuthStates{}

class SendCodeLoadingState extends AuthStates{}
class SendCodeSuccessState extends AuthStates{}
class SendCodeWrongState extends AuthStates{}
class SendCodeErrorState extends AuthStates{}

class VerificationCodeLoadingState extends AuthStates{}
class VerificationCodeSuccessState extends AuthStates{}
class VerificationCodeWrongState extends AuthStates{}
class VerificationCodeErrorState extends AuthStates{}