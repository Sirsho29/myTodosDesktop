String username = 'Anonymous';
int avatar = 4;
String shortTermGoal = 'Not selected';
bool isCallingLocalFirstTime = false;
List<String> todos = [];
var data;

getAvatarPath(int n) {
  if (n != null)
    return 'assets/avatar/$n.png';
  else
    return 'assets/avatar/4.png';
}
