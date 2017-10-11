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
ht.put("function","ord_infotree");
ht.put("lang",request.getAttribute("lang"));
ht.put("direction","0");
String lang = (String) request.getParameter("lang");

String enddate = DateTimeUtility.getSysTime(lang).substring(0,10);
String enddateISO = DateTimeUtility.getSysTime("hun").substring(0,10).replace(".","-");
String formatstr = DateTimeUtility.getDateFormat(lang); 
String formatstrHUN = DateTimeUtility.getDateFormat(lang);

String begindate=DateTimeUtility.getDateShift(enddate, -12, 'M', lang, formatstr);
String begindateISO = DateTimeUtility.getDateShift(enddate, -12, 'M', "hun", formatstrHUN).replace(".","-");

if(request.getParameter("bd")!=null) {
	begindate=((String)request.getParameter("bdate")).replace('-', '.');
}
if(request.getParameter("ed")!=null) {
	enddate=((String)request.getParameter("edate")).replace('-', '.');
}
String dtype_id = "0";//default
if(request.getParameter("dtype_id")!=null) {
	dtype_id = (String) request.getParameter("dtype_id");
}

String statuslista = "'0','1'";//default
if(request.getParameter("dtype_id")!=null) {
	statuslista = (String) request.getParameter("statuslista");
} 


ht.put("bd",begindate);
ht.put("ed",enddate);
ht.put("dtype_id",dtype_id);
ht.put("statuslista",statuslista);

Tools mytools = new Tools();
Hashtable langht = mytools.getLangTable(request,application);

String lista = mytools.getTableDatas(request,application,ht); 
%>  

<% if(request.getParameter("flag")==null) { %>
<div class="meti-date-interval">
  <label class="meti-date-label" for="date-begin"><%= langht.get("msg_date") %></label>
  <input class="meti-date-input meti-semi-square" type="date" id="date-begin" value="<%= begindateISO %>">
  <label class="meti-date-line" > - </label>
  <input class="meti-date-input meti-semi-square" type="date" id="date-end" value="<%= enddateISO %>">
  <label class="meti-date-label" for="select-datetype"><%= langht.get("postcorrect_141") %></label>
  <select id="datetype" value="dtype_id" class="meti-date-combo meti-semi-square">
  <option value="0"><%= langht.get("date_order") %></option>
  <option value="1"><%= langht.get("date_begin") %></option>
  </select>
</div>
<div class="meti-date-interval">
  
  <input type="checkbox" name="chk0" value="'0'" id="chk0" class="meti-date-chk" checked> <%= langht.get("msg_ordstat0") %> <br>
  <input type="checkbox" name="chk1" value="'1'" id="chk1" class="meti-date-chk" checked> <%= langht.get("msg_ordstat1") %> <br>
  <input type="checkbox" name="chk2" value="'2'" id="chk2" class="meti-date-chk" > <%= langht.get("msg_ordstat2") %> <br>
  <input type="checkbox" name="chk3" value="'3'" id="chk3" class="meti-date-chk" > <%= langht.get("msg_ordstat3") %> <br>
  <input type="checkbox" name="chk4" value="'4'" id="chk4" class="meti-date-chk" > <%= langht.get("msg_ordstat4") %> <br>
  <input type="checkbox" name="chk5" value="'5'" id="chk5" class="meti-date-chk" > <%= langht.get("msg_ordstat5") %> <br>
  <input type="checkbox" name="chk6" value="'6'" id="chk6" class="meti-date-chk" > <%= langht.get("msg_ordstat6") %> <br>
  <input type="checkbox" name="chk7" value="'7'" id="chk7" class="meti-date-chk" > <%= langht.get("msg_ordstat7") %> <br>
  <button type="submit" class="btn btn-primary meti-date-submit" onclick="orderinfo_supplier_loadtable(document.getElementById('date-begin').value,document.getElementById('date-end').value),document.getElementById('datetype').value,document.getElementById('chk0').checked,document.getElementById('chk1').checked,document.getElementById('chk2').checked,document.getElementById('chk3').checked,document.getElementById('chk4').checked,document.getElementById('chk5').checked,document.getElementById('chk6').checked,document.getElementById('chk').checked)" >OK</button>
  
</div>
<h1><%= langht.get("menu_orderinfo_supplier") %></h1>
<div id="tree-list-table">
<% }  %>
<%= lista %>
<% if(request.getParameter("flag")==null) { %>
</div>
<% }  %>
