/**
 * 
 */

$('details').click(function (event) {	
	if(this.parentNode.nodeName=="TD") {
		event.stopPropagation();
		return;
	}
    $('details').not(this).removeAttr("open");     
    });


function menuhandler(event,lang,userid,sid) {
	
	 var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	document.getElementById('bl_center').innerHTML = this.responseText;
	    	addResources("js/mytable.js");		    	   
	    }
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid="+event.id+"&function=stk_pllive", true);
	  xhttp.send();
}

