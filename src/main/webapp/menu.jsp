<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@page import="services.tools"%> 
<%@page import="util.SessionProvider"%>    
<% String sid = request.getParameter("sid");
   SessionProvider SP = SessionProvider.getInstance(null);
   if(sid==null || !SP.check_SID(sid)) {
	   request.getRequestDispatcher("/siderrorpage.jsp").forward(request, response);
   }
   String JSP_userid = ""+SP.getSession(sid).userid;
   request.setAttribute("userid", JSP_userid);
%>    

<div class="borderLayout">
	<div id="bl_top" class="top"></div>
	<div id="bl_left" class="left">
	 
	 <%@ include file = "menum.jsp" %>
	 
    </div>
	
	<div id="bl_center" class="center" onmousemove="mhandler(event,this)"></div>  
         
    <div id="bl_right" class="right"></div>
	<div id="bl_bottom" class="bottom"></div>

</div>