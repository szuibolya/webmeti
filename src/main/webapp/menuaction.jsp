<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="util.SessionProvider,
                util.ConnectionProvider,
                util.MetiSession"%> 
<% String sid = request.getParameter("sid");
   SessionProvider SP = SessionProvider.getInstance(null);   
   if(sid==null || !SP.check_SID(sid)) {
	   request.getRequestDispatcher("/siderrorpage.jsp").forward(request, response);
   }
   ConnectionProvider CP = ConnectionProvider.getInstance(null);
   MetiSession metisess = SP.getSession(sid);
   String userid = ""+metisess.userid;
   request.setAttribute("userid", userid);
   Long conn_id = metisess.connid;
   request.setAttribute("con",CP.getConnection(conn_id));
   request.setAttribute("lang",metisess.lang);
   String mid = request.getParameter("mid");
   request.getRequestDispatcher("/menucmds/"+mid+".jsp").forward(request, response);
%>   
