/// @description Create doorknob.

var this_x = (room_width / 2);
var this_y = (room_height / 2);
var this_depth = depth - 1;
var create_object = obj_doorknob;

instance_create_depth(this_x, this_y, this_depth, create_object);