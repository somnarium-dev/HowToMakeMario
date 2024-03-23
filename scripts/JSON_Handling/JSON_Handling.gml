// With thanks to Alice from the gamemaker forums. Found here:
//		https://forum.gamemaker.io/index.php?threads/json-save-system-via-buffer-quasi-invalid-response.93946/

/// @function fileReadAllText(filename)
/// @description Reads entire content of a given file as a string, or returns undefined if the file doesn't exist.
/// @param {string} filename        The path of the file to read the content of.
function fileReadAllText(_filename)
{
    if (!file_exists(_filename))
	{
        return undefined;
    }
    
    var _buffer = buffer_load(_filename);
    var _result = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _result;
}

/// @function fileWriteAllText(filename,content)
/// @description Creates or overwrites a given file with the given string content.
/// @param {string} filename        The path of the file to create/overwrite.
/// @param {string} content            The content to create/overwrite the file with.
function fileWriteAllText(_filename, _content)
{
    var _buffer = buffer_create(string_length(_content), buffer_grow, 1);
    buffer_write(_buffer, buffer_string, _content);
    buffer_save(_buffer, _filename);
    buffer_delete(_buffer);
}

/// @function jsonLoad(filename)
/// @description Loads a given JSON file into a GML value (struct/array/string/real).
/// @param {string} filename        The path of the JSON file to load.
function jsonLoad(_filename)
{
    var _json_content = fileReadAllText(_filename);
	
    if (is_undefined(_json_content))
        return undefined;
    
    try
	{
        return json_parse(_json_content);
    }
	
	catch (_)
	{
        // if the file content isn't a valid JSON, prevent crash and return undefined instead
        return undefined;
    }
}

/// @function jsonSave(filename,value)
/// @description Saves a given GML value (struct/array/string/real) into a JSON file.
/// @param {string} filename        The path of the JSON file to save.
/// @param {any} value                The value to save as a JSON file.
function jsonSave(_filename, _value)
{
    var _json_content = json_stringify(_value);
    fileWriteAllText(_filename, _json_content);
}

