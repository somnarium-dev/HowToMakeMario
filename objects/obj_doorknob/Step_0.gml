//Check to see if the mouse is hovering over the button.
var mouse_inside_width = false;
var mouse_inside_height = false;

if (mouse_x >= x)  
&& (mouse_x <= x + this_width)
{ mouse_inside_width = true; }

if (mouse_y >= y)  
&& (mouse_y <= y + this_height)
{ mouse_inside_height = true; }

if (mouse_inside_width)
&& (mouse_inside_height)
{ mouse_is_hovering = true;}

else
{ mouse_is_hovering = false; }

//Check to see if the button was clicked on.
if (!mouse_is_hovering) { exit; }

var mouse_was_clicked = mouse_check_button_pressed(mb_left);

if (mouse_was_clicked)
{ transitionIrisToRoom(Level_1_1); }