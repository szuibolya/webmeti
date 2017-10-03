<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="services.tools"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/sql" prefix="sql" %>

<% String sid = request.getParameter("sid");
   if(sid==null || !tools.sessions.containsKey(sid)) {	  
	   request.getRequestDispatcher("/siderrorpage.jsp").forward(request, response);
   }
   tools.sessions.remove(sid);
   String osid=sid;
   sid = tools.createSessionid(12);
%>
<div id="mainroot">
<span id ="<%=osid%>" newid="<%=sid%>"></span>
<sql:setDataSource var="dataSource" driver="org.postgresql.Driver"
                   url="jdbc:postgresql://localhost/tesztbf7"
                   user="postgres"  password="postgres"/>


<sql:query var = "result" dataSource="${dataSource}">
SELECT DISTINCT NL as langname,L_ISO3166 as lang,NI as lang3,ID 
FROM ALL_L
WHERE IV=1
ORDER BY ID
</sql:query>
<div id="root" class="jumbotron">
<div class="container">
<div class="col-sm-8 col-sm-offset-2">
<div border=1 class="container-lang">
<c:forEach var="row" items="${result.rows}">
<div>
<img class="langimage"  src="<%=request.getContextPath()%>/resources/images/<c:out value="${row.lang}"/>.png" id="<c:out value="${row.lang3}"/>" onclick="loginform(this.id)"/>

<h3 class="langtext"><c:out value="${row.langname}"/></h3>
</div>
</c:forEach>
</div>
</div>
</div>
</div>
</div>