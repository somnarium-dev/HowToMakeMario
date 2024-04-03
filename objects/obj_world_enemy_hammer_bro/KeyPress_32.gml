if (state == enemy_map_state.idle)
{
	shuffle_moves_remaining = irandom_range(1, 5);
	state = enemy_map_state.shuffle;
}