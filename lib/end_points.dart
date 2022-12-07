const LOGIN = 'login';
const HOME = 'home';
const Favorites = 'favorites';
const Categories = 'categories';
const PROFILE = 'profile';
const REGISTER = 'register';
const updateProfile = 'update-profile';

String token='';

void PrintFullText(String Text){
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(Text).forEach((element) {print(element.group(0));});
}