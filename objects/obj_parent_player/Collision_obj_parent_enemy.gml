checkForHarmfulEnemyCollision();

//If touching the enemy hurt you this frame, don't kick it this frame.
if (damage_data.inflicted_type != damage_type.none) { return; }

checkForShellKicks();