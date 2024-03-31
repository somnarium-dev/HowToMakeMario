///@desc State Machine

// Inherit the parent event
event_inherited();

state_machine[item_state.idle] = function()
{ handleItemBoxContentsMovementAndCollision(); }