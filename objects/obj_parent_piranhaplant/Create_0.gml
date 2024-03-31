// Inherit the parent event
event_inherited();

// Load create data.
direction = create_direction;

if (!is_spitter)
{  image_angle = direction; }

// Configuration
process_gravity = false;
bounce_attacker_when_jump_attacked = false;
process_collision_detection = false;

// Internal Functionality
extension = 0;
extension_increment = -0.75;

hide_timing = 60;
pre_attack_timing = 30;
attack_timing = 30;
post_attack_timing = 30;

// Internal Functionality - Spitter Specific
mouth_is_open = false;
mouth_shut_timing = 30;

current_target = noone;

// Associated Objects
threat_detector = createPiranhaPlantThreatDetector();

// Initialize
behavior = enemy_behavior.hide;