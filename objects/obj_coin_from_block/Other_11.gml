///@desc State Machine

// Inherit the parent event
event_inherited();

state_machine[item_from_block_state.appear] = function()
{
	handleItemBoxContentsMovementAndCollision();
	
	//Destroy the object and increase coin count for the collector.
	if (v_speed > 0) 
	&& (y >= ending_y_position)
	{ 
		var this_effect = instance_create_layer(x, y, "Players", obj_effect_coin_collected);
		if (collector != noone) { collectCoin(collector, 1) }
		instance_destroy();	
	}
}