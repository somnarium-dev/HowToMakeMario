// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

//Load create data.
direction = create_direction;

//Settings
process_collision_detection = false;

//Unique Attributes
extension = 0;
extension_increment = -0.75;

hide_timing = 60;
pre_attack_timing = 30;
attack_timing = 30;
post_attack_timing = 30;

//Spitter Specific Attributes
mouth_is_open = false;
mouth_shut_timing = 30;

current_target = noone;

//Associated Objects

//I do not know how to do cos and sin correctly yet because I feel like these values should be negative!
//FUCKED UP STUPID BACKWARDS WORLD WHO CARES.

show_debug_message($"{direction}");

var detector_cos_offset_amount = -8 + (pipe_length_tiles * 16);
var detector_sin_offset_amount = 16;

var detector_cos_offset_direction = (direction + 180) mod 360;
var detector_sin_offset_direction = (direction + 90) mod 360;

var detector_cos_offset_x = lengthdir_x(detector_cos_offset_amount, detector_cos_offset_direction);
var detector_cos_offset_y = lengthdir_y(detector_cos_offset_amount, detector_cos_offset_direction);

var detector_sin_offset_x = lengthdir_x(detector_sin_offset_amount, detector_sin_offset_direction);
var detector_sin_offset_y = lengthdir_y(detector_sin_offset_amount, detector_sin_offset_direction);

var detector_total_offset_x = detector_cos_offset_x + detector_sin_offset_x;
var detector_total_offset_y = detector_cos_offset_y + detector_sin_offset_y;

threat_detector =	instance_create_layer
					(
						x + detector_total_offset_x,
						y + detector_total_offset_y,
						"System",
						obj_player_detector,
						{
							source: id,
							direction: direction,
							follow_source: false,
							width_tiles: pipe_length_tiles,
							height_tiles: 2
						}
					);

//Initialize
behavior = enemy_behavior.hide;