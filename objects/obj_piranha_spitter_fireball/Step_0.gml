handleExecutionPauses(id);
if (paused) { exit; }

// Move steadily in the object's direction.
handlePixelAccumulation();
updateObjectPosition();