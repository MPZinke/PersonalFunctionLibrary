<?php 


/* -get values for unknown amount of elements based on single tag or an array of tags.
	The names of the values should increment and the loop will stop once the the count
	exceeds 100 or the filtered input is NULL or equals halt_value
	-$value holds first (or only) element and evalutates if it is null at end of each loop */
function get_tags($tag, $halt_value="") {
	$count = 1;
	$values = array();

	do {
		// get each tag from tag array
		if(is_array($tag)) {
			$var = array();  // temp array to hold gotten tags & be added to $values
			foreach($tag as $attribute) {
				$var[] = filter_input(INPUT_POST, $attribute.$count);
			}
			$value = $var[0];
		}
		else $value = $var = filter_input(INPUT_POST, $tag.$count);  // single tag: get tag

		if($value) $values[] = $var;  // add value to list if not null
	// stop if no value, terminating value, or has gone on too long
	} while($value && $value != $halt_value && ++$count < 100);
	return $values;
}


?>