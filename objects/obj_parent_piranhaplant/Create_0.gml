// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

image_speed = 0;

extension = 0;
extension_increment = -0.75;

stay_hidden_range = 21;

hide_timing = 60;
pre_attack_timing = 30;
attack_timing = 30;
post_attack_timing = 30;

is_spitter = true;
mouth_is_open = false;
mouth_shut_timing = 30;

process_collision_detection = false;

behavior = enemy_behavior.hide;