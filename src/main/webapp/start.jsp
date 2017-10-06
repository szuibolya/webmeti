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
<style>
.meti-menu-level-0 {
  background: #ecf0f1;
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
  padding-top:0px;
  padding-right:10px;
  padding-bottom:0px;
  padding-left:10px;
  
 
}
.meti-menu-level-0-title {
  display: block;
  background: #3498db;
  border: 1px solid white;
  color: white;
  padding: 10px;
}

.meti-menu-table {
   display: table;
   padding:5px;
   width: 100%;
   max-width: 100%;
   border: 1px solid white;
   margin:5px 5px 0px 0px;
   
}
.meti-menu-table>tbody>tr>td {
    padding-top:2px;
    padding-right:10px;
    padding-bottom:2px;
    padding-left:10px;
    line-height: 1.42857143;
    vertical-align: top;
    border-top: 1px solid white;
}

.meti-menu-submenu {
  display:table-row;
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
  color: #2874A6;
  padding: 10px
  
}

.meti-menu-submenu-list{
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
  color: white;
  background:#48c9b0;
  padding: 10px
  
}

.meti-menu-submenu-list-table {
   display: table;
   padding:5px;
   width: 100%;
   max-width: 100%;
   border: 1px solid white;
   margin:5px 0px 0px 10px;
   
}

.meti-menu-submenu-list-table>p {
    display: inline-block;
    padding-left: 10px;
    text-indent: -10px;
    line-height: 1.42857143;
    vertical-align: top;
    border-top: 1px solid white;
    -webkit-box-decoration-break: clone;
    box-decoration-break: clone;
}
.meti-menu-submenu-list-table>p>a{
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size:14px;
  color: #0B5345;
  padding: 10px
}

</style>
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