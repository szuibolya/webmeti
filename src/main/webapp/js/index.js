/**
 * 
 */

function doLogin(){	
	u = document.getElementById("username").value;
	s = document.getElementById("password").value;
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	       if(this.responseText.startsWith("OK")) {
	    	   sessionStorage.sid = this.responseText.split(" ")[1];
	    	   document.getElementById("onLoadImg").style.display = "inline-block";
	     	   var xhttp = new XMLHttpRequest();
	     	    xhttp.onreadystatechange = function() {
	     	    if (this.readyState == 4 && this.status == 200) {
	     	      document.getElementById("mainroot").innerHTML =  this.responseText;
	     	      addResources("js/main.js","css/main.css");
	     	      addResources("js/menu_click.js","css/menu.css");
	     	      addResources("js/webmeti.js","css/webmeti.css");
	     	      top.document.title = "Webmeti";
	     	    }
	     	  }
	     	  xhttp.open("GET", "menu.jsp?sid="+sessionStorage.sid, true);
	     	  xhttp.send();
	       }
	    }
	  };
	  xhttp.open("POST", "HS", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhttp.send("function=login&sid="+sessionStorage.sid+"&u="+u+"&p="+SHA1(s)+"&langicon="+sessionStorage.lang);
	  
 	    
}

function loginform(id){
 var xhttp = new XMLHttpRequest();
 xhttp.onreadystatechange = function() {
   if (this.readyState == 4 && this.status == 200) {
     document.getElementById("root").innerHTML =  this.responseText;
     var _in = document.getElementsByTagName("HEAD")[0];
     var scriptNode = document.createElement('script');    
     scriptNode.setAttribute("src", "js/sha1.js");
     _in.appendChild(scriptNode);
     top.document.title = "Login";
   }
 };
 sessionStorage.lang = id;
 xhttp.open("GET", "login.jsp?lang="+id+"&sid="+sessionStorage.sid, true);
 xhttp.send();
}