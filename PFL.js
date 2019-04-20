/**********************************************************
*
*	@author MPZinke
*
*	Personal Function Library: JS
*	April 13, 2019
*	-DESCRIPTION: General Functions to be used
*	 for JS/Web development
*
**********************************************************/


/* personal implimentation for creating a tag for data sorting
	ARGS: -function of things to do after tag is closed,
			-the text that will display within the tag
			-element to which tage is added */
function create_tag(functionality, inner_element, parent) {
	var tag = document.createElement("div");
	var close = document.createElement("button");

	// appearance
	close.style = inner_element.style = "background-color:inherit;border-style:none;height:100%;display:inline-block;";
	tag.style = 'background-color:#E8E8E8;border-style:solid;border-color:#fff;border-radius:5px;border-width:3px;display:inline-block;text-align:justify;';

	// close button event
	close.innerHTML = "&#215";
	close.onclick = function() {
		parent.removeChild(tag);  // remove self
		functionality();  // user specified proceeding function
	};

	// add parts to tag; add tag to parent
	tag.appendChild(inner_element);
	tag.appendChild(close);
	parent.appendChild(tag);	

	return tag;
}