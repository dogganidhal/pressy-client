

abstract class Validators {

  static String emailValidator(String email) {

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (email.length == 0) {
      return null;
    } else if(!regExp.hasMatch(email)){
      return "Adresse Email invalide";
    }
    return null;

  }

  static String newPasswordValidator(String password) {

    if (password == null || password.isEmpty) return null;
    if (password.length < 6)
      return "Le mot de passe doit avoir au moins 6 caractères";
    if (!password.contains(new RegExp("(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)")))
      return "Le mot de passe doit avoir au moins une lettre et un chiffre";
    return null;

  }

  static String loginPasswordValidator(String password) => password.isNotEmpty ? null : "Mot de passe vide";

  static String phoneNumberValidator(String email) => null;
  static String nameValidator(String password) => null;
  static String passwordConfirmationValidator(String password, String passwordConfirmation) => null;

}