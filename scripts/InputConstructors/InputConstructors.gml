enum INPUT_AXIS {
    right,
    up,
    left,
    down
}

function Input(_manager) constructor {
    __manager = _manager;
    __time = 0;
    __keys = [];

    // Called by input manager's run method
    __update = function() {
        var active = false;

        var len = array_length(__keys);
        for (var i = 0; i < len; i++) {
            if (__keys[i].check()) {
                active = true;
                break;
            }
        }

        if (active)
            __time++;
        else if (__time > 0)
            __time = -__manager.buffer;
        else
            __time = min(__time + 1, 0);
    }

    add_keyboard_key = function(_key) {
        var key = {
            button: _key,
            check: function() {
                return keyboard_check(button);
            }
        };

        array_push(__keys, key);
        return self;
    }

    add_gamepad_button = function(_button) {
        var key = {
            creator: other,
            button: _button,
            check: function() {
				return gamepad_button_check(creator.__manager.gamepad, button);
			}
        };

        array_push(__keys, key);
        return self;
    }

    add_gamepad_left_stick = function(_direction) {
        var key = {
            creator: other,
            axis: _direction == INPUT_AXIS.right || _direction == INPUT_AXIS.left ?
                gp_axislh :
                gp_axislv,
            dir: _direction == INPUT_AXIS.right || _direction == INPUT_AXIS.down ?
                1 :
                -1,
            check: function() {
                return gamepad_axis_value(creator.__manager.gamepad, axis) * dir >= creator.__manager.deadzone;
            }
        }

        array_push(__keys, key);
        return self;
    }

    add_gamepad_right_stick = function(_direction) {
        var key = {
            creator: other,
            axis: _direction == INPUT_AXIS.right || _direction == INPUT_AXIS.left ?
                gp_axisrh :
                gp_axisrv,
            dir: _direction == INPUT_AXIS.right || _direction == INPUT_AXIS.down ?
                1 :
                -1,
            check: function() {
                return gamepad_axis_value(creator.__manager.gamepad, axis) * dir >= creator.__manager.deadzone;
            }
        }

        array_push(__keys, key);
        return self;
    }

    // Check for a hold
    check = function() {
        return __time > 0;
    }

    // Check for a press
    check_pressed = function(_buffered = false) {
        if (_buffered)
               return __time > 0 && __time <= __manager.buffer;
        return __time == 1;
    }

    // Check for a release
    check_released = function(_buffered = false) {
        if (_buffered)
            return __time < 0;
        return __time == -__manager.buffer;
    }

    // Check for sporadic presses over intervals of time
    check_stutter = function(_initial_delay, _interval) {
        if (__time == 1)
            return true;

        return __time - _initial_delay > 0 && (__time - _initial_delay) % _interval == 0;
    }

    // Sets input to a state that a buffered press check does not find true
    fully_press = function() {
        __time = __manager.buffer + 1;
    }

    // Sets input to a state that a buffered release check does not find true
    fully_release = function() {
        __time = 0;
    }
}

function generate_standard_inputs()
{
	input_manager = new InputManager();
	
	right = input_manager.create_input();
	right
			.add_keyboard_key(vk_right)
			.add_gamepad_button(gp_padr)
			.add_gamepad_left_stick(INPUT_AXIS.right);

	up = input_manager.create_input();
	up
			.add_keyboard_key(vk_up)
			.add_gamepad_button(gp_padu)
			.add_gamepad_left_stick(INPUT_AXIS.up);

	left = input_manager.create_input()
	left
			.add_keyboard_key(vk_left)
			.add_gamepad_button(gp_padl)
			.add_gamepad_left_stick(INPUT_AXIS.left);

	down = input_manager.create_input()
	down
			.add_keyboard_key(vk_down)
			.add_gamepad_button(gp_padd)
			.add_gamepad_left_stick(INPUT_AXIS.down);
			
	confirm = input_manager.create_input()
	confirm
			.add_keyboard_key(ord("Z"))
			.add_gamepad_button(gp_face2);
			
	cancel = input_manager.create_input()
	cancel
			.add_keyboard_key(ord("X"))
			.add_gamepad_button(gp_face1);
			
	run = input_manager.create_input()
	run
			.add_keyboard_key(ord("Z"))
			.add_gamepad_button(gp_face3);
			
	jump = input_manager.create_input()
	jump
			.add_keyboard_key(ord("X"))
			.add_gamepad_button(gp_face1);
			
	start = input_manager.create_input()
	start
			.add_keyboard_key(vk_enter)
			.add_gamepad_button(gp_start);

	input_manager.fully_press_all();
}

