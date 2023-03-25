import 'package:my_schedule/list_classes.dart';
import 'package:my_schedule/new_class.dart';

const String HOME_PAGE = '/';
const String ADD_CLASS_PAGE = '/new';

var routesOfApp = {
  HOME_PAGE: (context) => const ListClasses(),
  ADD_CLASS_PAGE: (context) => const NewClass(),
};