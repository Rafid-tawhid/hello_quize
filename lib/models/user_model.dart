class UserModel{
   String id;
   String name;
   String image;
   String email;

   UserModel(this.id, this.name, this.image, this.email);

}

class UserAllInfo{
  static UserModel? userModel;

  static setUserInfo(UserModel info){
    userModel=info;
  }

  static getUserInfo()=>userModel;
}
