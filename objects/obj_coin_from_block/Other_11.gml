///@desc 

// Inherit the parent event
event_inherited();

state_machine[item_from_block_state.appear] = function()
{
	v_speed = -popup_strength;
	state = item_from_block_state.jump;
}

state_machine[item_from_block_state.jump] = function()
{
	handleItemBoxContentsMovementAndCollision();
	
	if (v_speed > 0)
	{ state = item_from_block_state.fall; }
}

state_machine[item_from_block_state.fall] = function()
{
	handleItemBoxContentsMovementAndCollision();
	
	if (y >= ending_y_position)
	{ state = item_from_block_state.destroyed; }
}

state_machine[item_from_block_state.destroyed] = function()
{
	var this_effect = instance_create_layer(x, y, "Players", obj_effect_coin_collected);
	this_effect.depth = depth - 1;
	if (collector != noone) { collectCoin(collector, 1) }
	instance_destroy();
}