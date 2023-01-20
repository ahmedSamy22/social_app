abstract class RegisterStates{}

class RegisterInitState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{

}

class RegisterErrorState extends RegisterStates{}

class ChangeRegisterPasswordState extends RegisterStates{}

class CreateUserSuccessState extends RegisterStates{}

class CreateUserErrorState extends RegisterStates{}

