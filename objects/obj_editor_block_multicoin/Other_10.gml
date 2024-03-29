///@desc 

// Inherit the parent event
event_inherited();

///@func generateContents()
generateContents = function()
{
	//This will vary depending on the object,
	//but the below function should cover most cases.
	
	if (contents == undefined) { return; }
	
	playSFX(contents_sfx);
	
	var these_contents = instance_create_layer(x, y, "Players", contents);
	these_contents.depth = depth + 1;
	these_contents.collector = strike_data.striker;
	
	coins_remaining--;
	
	if (coins_remaining < 1)
	{
		contents = undefined;
		idle_sprite = hit_sprite;
	}
}