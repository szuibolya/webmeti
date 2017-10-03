<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="services.tools"%>
<%@ page import="tools.Tools"%>
<%@ page import="java.util.Hashtable"%>

<% String sid = request.getParameter("sid");
   if(sid==null || !tools.sessions.containsKey(sid)) {
	   request.getRequestDispatcher("/siderrorpage.jsp").forward(request, response);
   }
%>
<% 
  Tools mytools = new Tools();
  Hashtable langht = mytools.getLangTable(request,application);
%>


<div class="jumbotron">
<div class="container">
<div class="col-sm-8 col-sm-offset-2">
<div class="col-md-6 col-md-offset-3">
    <h2><%= langht.get("login_title") %></h2>
    
        <div class="form-group" >
            <label for="username"><%= langht.get("loginfrm_usr_lbl") %></label>
            <input type="text" name="username" value="Papp Miklós" id="username" class="form-control"  required  oninvalid="this.setCustomValidity('<%= langht.get("msg_required_field_missing") %>'+': '+'<%= langht.get("loginfrm_usr_lbl") %>')"
    oninput="setCustomValidity('')" />
        </div>
        <div class="form-group" >
            <label for="password"><%= langht.get("lawuser_frm_pwd") %></label>
            <input type="password" name="password" value="huki8" id="password" class="form-control" required="true" oninvalid="this.setCustomValidity('<%= langht.get("msg_required_field_missing") %>'+': '+'<%= langht.get("lawuser_frm_pwd") %>')"
    oninput="setCustomValidity('')"/>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary" onclick="doLogin()" id="doLoginBtn"><span class="glyphicon glyphicon-ok-sign"></span> <%= langht.get("login_title") %></button>
            <img  style="display:none" id="onLoadImg" src="data:image/gif;base64,R0lGODlhEAAQAPIAAP///wAAAMLCwkJCQgAAAGJiYoKCgpKSkiH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAAEAAQAAADMwi63P4wyklrE2MIOggZnAdOmGYJRbExwroUmcG2LmDEwnHQLVsYOd2mBzkYDAdKa+dIAAAh+QQJCgAAACwAAAAAEAAQAAADNAi63P5OjCEgG4QMu7DmikRxQlFUYDEZIGBMRVsaqHwctXXf7WEYB4Ag1xjihkMZsiUkKhIAIfkECQoAAAAsAAAAABAAEAAAAzYIujIjK8pByJDMlFYvBoVjHA70GU7xSUJhmKtwHPAKzLO9HMaoKwJZ7Rf8AYPDDzKpZBqfvwQAIfkECQoAAAAsAAAAABAAEAAAAzMIumIlK8oyhpHsnFZfhYumCYUhDAQxRIdhHBGqRoKw0R8DYlJd8z0fMDgsGo/IpHI5TAAAIfkECQoAAAAsAAAAABAAEAAAAzIIunInK0rnZBTwGPNMgQwmdsNgXGJUlIWEuR5oWUIpz8pAEAMe6TwfwyYsGo/IpFKSAAAh+QQJCgAAACwAAAAAEAAQAAADMwi6IMKQORfjdOe82p4wGccc4CEuQradylesojEMBgsUc2G7sDX3lQGBMLAJibufbSlKAAAh+QQJCgAAACwAAAAAEAAQAAADMgi63P7wCRHZnFVdmgHu2nFwlWCI3WGc3TSWhUFGxTAUkGCbtgENBMJAEJsxgMLWzpEAACH5BAkKAAAALAAAAAAQABAAAAMyCLrc/jDKSatlQtScKdceCAjDII7HcQ4EMTCpyrCuUBjCYRgHVtqlAiB1YhiCnlsRkAAAOwAAAAAAAAAAAA==" />
        </div>
    
</div>
</div>
</div>
</div>