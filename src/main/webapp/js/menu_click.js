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
	    	var start = this.responseText.indexOf("<script>");
	    	if(start!=-1) {
	    		start=start+8;
	    		var end = this.responseText.indexOf("</script>");
		    	var script = this.responseText.slice(start,end);
		    	eval(script);
	    	}
	    	
	    }
	    if (this.readyState == 4 && this.status != 200) {
	    	document.getElementById('bl_center').innerHTML = this.responseText;	    	  	  
	    }
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid="+event.id+"&lang="+sessionStorage.lang, true);
	  xhttp.send();
}

