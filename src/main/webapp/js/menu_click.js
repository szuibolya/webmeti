/**
 * 
 */
function menuhandler(event,lang,userid,sid) {
	
	 var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	document.getElementById('bl_center').innerHTML = this.responseText;
	    	/*addResources("js/index.js","css/index.css");*/		    	   
	    }
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid="+event.id, true);
	  xhttp.send();
}
