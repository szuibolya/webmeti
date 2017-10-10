<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="blayer.bl_stk_services,
                tools.Tools,
                java.sql.Connection,
                util.MetiResponse,
                javax.swing.table.DefaultTableModel,
                java.util.*,datastore.DateTimeUtility"%> 
<%
bl_stk_services bl = new bl_stk_services();
Hashtable ht = new Hashtable();
ht.put("function","lst_ssd");
ht.put("lang",request.getAttribute("lang"));
ht.put("colname","1");
String lang = (String) request.getParameter("lang");

String enddate = DateTimeUtility.getSysTime(lang).substring(0,10);
String enddateISO = DateTimeUtility.getSysTime("hun").substring(0,10).replace(".","-");
String formatstr = DateTimeUtility.getDateFormat(lang); 
String formatstrHUN = DateTimeUtility.getDateFormat(lang);

String begindate=DateTimeUtility.getDateShift(enddate, -6, 'M', lang, formatstr);
String begindateISO = DateTimeUtility.getDateShift(enddate, -6, 'M', "hun", formatstrHUN).replace(".","-");

if(request.getParameter("bdate")!=null) {
	begindate=((String)request.getParameter("bdate")).replace('-', '.');
}
if(request.getParameter("edate")!=null) {
	enddate=((String)request.getParameter("edate")).replace('-', '.');
}

ht.put("pars",begindate+";"+enddate);
Tools mytools = new Tools();
Hashtable langht = mytools.getLangTable(request,application);

String lista = mytools.getTableDatas(request,application,ht); 
%>  

<% if(request.getParameter("flag")==null) { %>
<div class="meti-date-interval">
  <label class="meti-date-label" for="date-begin"><%= langht.get("msg_date") %></label>
  <input class="meti-date-input" type="date" id="date-begin" value="<%= begindateISO %>">
  <label class="meti-date-line" > - </label>
  <input class="meti-date-input" type="date" id="date-end" value="<%= enddateISO %>">
  <button type="submit" class="btn btn-primary meti-date-sumbmit" onclick="storestockdate_list_loadtable(document.getElementById('date-begin').value,document.getElementById('date-end').value)" >OK</button>
</div>
<h1><%= langht.get("menu_storestockdate_list") %></h1>
<div id="storestockdate-list-table">
<% }  %>
<%= lista %>
<% if(request.getParameter("flag")==null) { %>
</div>
<% }  %>
