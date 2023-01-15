import 'package:hive/hive.dart';
import 'package:hivedatabase/Models/nodes_model.dart';



class Boxes{

  static Box<NotesModel> getData()=> Hive.box<NotesModel>('notes');




}