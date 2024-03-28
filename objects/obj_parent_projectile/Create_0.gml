// Inherit the parent event
event_inherited();

//Configuration
damaging_to = obj_parent_player;

damage_data.inflicted_type = damage_type.touch;
damage_data.inflicted_power = 1;
damage_data.attacker = id;