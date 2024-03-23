function InputManager(_gamepad = 0, _deadzone = 0.4) constructor {
    __inputs = []; // total inputs
    gamepad = _gamepad; // gamepad number
    deadzone = _deadzone; // gamepad axis deadzone
    buffer = 5; // how many frames of wiggle room buffered checks get

    // Call in step to update manager
    run = function() {
        var len = array_length(__inputs);
        for (var i = 0; i < len; i++)
            __inputs[i].__update();
    }

    create_input = function() {
        var _input = new Input(self);
        array_push(__inputs, _input);
        return _input;
    }
	
	fully_press_all = function() {
    for (var i = 0; i < array_length(__inputs); i++)
        __inputs[i].fully_press();
	}
}