<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="services.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Cache-Control" content="no-cache,no-store,must-revalidate"/>

 <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="dist/themes/default/style.min.css" />
<script src="dist/jstree.min.js"></script>

<%
String preflang = request.getHeader("accept-language").split(",")[0];
preflang = tools.getlangselecttitle(preflang);
String sid = tools.createSessionid(12);
%>
<title><%=preflang%></title>

</head>
<body>
<script>

function addResources(js,css) {
	var _in = document.getElementsByTagName("HEAD")[0];
    var scriptNode = document.createElement('script');    
    scriptNode.setAttribute("src", js)
    _in.appendChild(scriptNode);
    if(css!=undefined) {
	    var linkNode = document.createElement('link');
	    linkNode.setAttribute("rel", "stylesheet");
	    linkNode.setAttribute("href", css)
	    _in.appendChild(linkNode);
    }
}

function loadDoc() {
	sessionStorage.sid = <%=sid%>;
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	document.getElementsByTagName('body')[0].innerHTML = this.responseText;
	    	addResources("js/index.js","css/index.css");	
	    	sessionStorage.sid = document.getElementById(sessionStorage.sid).attributes["newid"].value;    	
	    }
	  };
	  xhttp.open("GET", "index.jsp?sid="+sessionStorage.sid, true);
	  xhttp.send();
	  
	}

loadDoc();
</script>
</body>
</html>