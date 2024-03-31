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
    updateInputs = function() {
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

    addKeyboardKey = function(_key) {
        var key = {
            button: _key,
            check: function() {
                return keyboard_check(button);
            }
        };

        array_push(__keys, key);
        return self;
    }

    addGamepadButton = function(_button) {
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

    addGamepadLeftStick = function(_direction) {
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

    addGamepadRightStick = function(_direction) {
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
    checkPressed = function(_buffered = false) {
        if (_buffered)
               return __time > 0 && __time <= __manager.buffer;
        return __time == 1;
    }

    // Check for a release
    checkReleased = function(_buffered = false) {
        if (_buffered)
            return __time < 0;
        return __time == -__manager.buffer;
    }

    // Check for sporadic presses over intervals of time
    checkStutter = function(_initial_delay, _interval) {
        if (__time == 1)
            return true;

        return __time - _initial_delay > 0 && (__time - _initial_delay) % _interval == 0;
    }

    // Sets input to a state that a buffered press check does not find true
    fullyPress = function() {
        __time = __manager.buffer + 1;
    }

    // Sets input to a state that a buffered release check does not find true
    fullyRelease = function() {
        __time = 0;
    }
}

function generateStandardInputs()
{
	input_manager = new InputManager();
	
	right = input_manager.createInput();
	right
			.addKeyboardKey(vk_right)
			.addGamepadButton(gp_padr)
			.addGamepadLeftStick(INPUT_AXIS.right);

	up = input_manager.createInput();
	up
			.addKeyboardKey(vk_up)
			.addGamepadButton(gp_padu)
			.addGamepadLeftStick(INPUT_AXIS.up);

	left = input_manager.createInput()
	left
			.addKeyboardKey(vk_left)
			.addGamepadButton(gp_padl)
			.addGamepadLeftStick(INPUT_AXIS.left);

	down = input_manager.createInput()
	down
			.addKeyboardKey(vk_down)
			.addGamepadButton(gp_padd)
			.addGamepadLeftStick(INPUT_AXIS.down);
			
	confirm = input_manager.createInput()
	confirm
			.addKeyboardKey(ord("Z"))
			.addGamepadButton(gp_face2);
			
	cancel = input_manager.createInput()
	cancel
			.addKeyboardKey(ord("X"))
			.addGamepadButton(gp_face1);
			
	run = input_manager.createInput()
	run
			.addKeyboardKey(ord("Z"))
			.addGamepadButton(gp_face3);
			
	jump = input_manager.createInput()
	jump
			.addKeyboardKey(ord("X"))
			.addGamepadButton(gp_face1);
			
	start = input_manager.createInput()
	start
			.addKeyboardKey(vk_enter)
			.addGamepadButton(gp_start);

	input_manager.fullyPressAll();
}

