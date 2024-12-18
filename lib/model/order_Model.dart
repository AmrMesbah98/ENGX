import 'package:json_annotation/json_annotation.dart';
part 'order_Model.g.dart';
@JsonSerializable()
class MakeOrder{
String id;
String order;
String name;
String email;
String Address;
String phone;
String type;

MakeOrder( this.id,this.order,this.name,this.email,this.Address,this.phone,this.type);

factory MakeOrder.fromJson(Map<String ,dynamic> json)=>_$MakeOrderFromJson(json);
Map<String,dynamic> toJson()=>_$MakeOrderToJson(this);
}