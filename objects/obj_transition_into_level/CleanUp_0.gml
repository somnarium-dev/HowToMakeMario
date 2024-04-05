// Make sure that the surface used to draw the iris effect is properly disposed.
// Otherwise, it needlessly uses space in memory.
if (surface_exists(transition_surface))
{ surface_free(transition_surface); }