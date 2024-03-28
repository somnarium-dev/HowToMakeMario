// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

//Load create data.
direction = create_direction;

//Configuration
bounce_when_jump_attacked = false;
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
threat_detector = createPiranhaPlantThreatDetector();

//Initialize
behavior = enemy_behavior.hide;