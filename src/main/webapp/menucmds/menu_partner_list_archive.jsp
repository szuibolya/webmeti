<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="blayer.bl_stk_services,
                tools.Tools,
                java.sql.Connection,
                util.MetiResponse,
                javax.swing.table.DefaultTableModel,
                java.util.*"%> 
<%
bl_stk_services bl = new bl_stk_services();
Hashtable ht = new Hashtable();
ht.put("lang",request.getAttribute("lang"));
/*
MetiResponse mr = new MetiResponse(bl.stk_partner_list_live((Connection)request.getAttribute("con"), ht));
DefaultTableModel dtm = (DefaultTableModel)mr.getHt().get("dtm");
String lista = Tools.plainTextfromDtm(dtm," ",ht,false);*/
String lista = new Tools().getTableDatas(request,application,"stk_pal"); 
%>
<h1>Partnerlista archive</h1>
<%= lista %>