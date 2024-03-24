// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

image_speed = 0;

extension = 0;
extension_increment = 1;

hide_timing = 20;
pre_attack_timing = 20;
attack_timing = 20;
post_attack_timing = 20;

is_spitter = true;
mouth_is_open = false;
mouth_shut_timing = 10;

process_collision_detection = false;

behavior = enemy_behavior.hide;