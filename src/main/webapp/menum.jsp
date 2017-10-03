<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/sql" prefix="sql" %>

<% long lUserId = Long.valueOf((String)request.getAttribute("userid")).longValue(); %>

<sql:setDataSource var="dataSource" driver="org.postgresql.Driver"
                   url="jdbc:postgresql://localhost/tesztbf7"
                   user="postgres"  password="postgres"/>



<c:set var = "nUserId" scope = "session" value ="${requestScope.userid}" />

<sql:query var = "result" dataSource="${dataSource}" maxRows="500">
SELECT DISTINCT 'accordion'||LPAD(CASE WHEN MENUTYPE IN ('0','2') THEN COALESCE(IDPARENTMENU,'0') ELSE COALESCE(IDMENU,'0') END,10,'0') AS accordion,
htmlid,
COALESCE((SELECT MIN(htmlid) from LAW_M WHERE IDPARENTMENU=M.IDMENU),'') AS firstchild,
COALESCE(CASE ? WHEN 'hun' THEN LN.HUN WHEN 'ger' THEN LN.GER WHEN 'eng' THEN LN.ENG 
       WHEN 'rom' THEN LN.ROM WHEN 'ukr' THEN LN.UKR WHEN 'slk' THEN LN.SLK END,LN.HUN) AS txt,
COALESCE(IDNAME,'') AS idname,
COALESCE(CAST(MENUTYPE AS VARCHAR),'0') AS menutype,
CAST(L AS VARCHAR) AS menulevel,
IDMENU AS idmenu
FROM public.LAW_M M 
JOIN public.ALL_LN LN 
ON LN.NAME=M.IDNAME
WHERE (M.IV = 1 AND M.ID IN (SELECT ID_M FROM public.LAW_RI 
                        WHERE IV=1 AND ID_R IN (SELECT ID_R FROM public.LAW_UR 
                                                WHERE IV=1 AND (ID_U = CAST(? AS BIGINT) OR ID_U IN (SELECT ID_U_WM FROM public.LAW_S WHERE ID_U_W=CAST(? AS BIGINT) AND IV=1)
                                                               )
                                                )
                       ) 
      )
OR ((MENUTYPE='2' AND M.IV=1) OR (MENUTYPE='1' AND M.IV=1 AND (M.L=0 OR IDMENU IN (SELECT IDPARENTMENU FROM public.LAW_M 
                                                                               WHERE IV = 1 AND ID IN (SELECT ID_M FROM public.LAW_RI 
                                                                                                       WHERE IV=1 AND ID_R IN (SELECT ID_R FROM public.LAW_UR 
                                                                                                                               WHERE IV= 1 AND (ID_U = CAST(? AS BIGINT) OR ID_U IN (SELECT ID_U_WM FROM public.LAW_S 
                                                                                                                               WHERE ID_U_W=CAST(? AS BIGINT) AND IV=1))
                                                                                                                               )
                                                                                                       )
                                                                               )
                                                            )
                                 )
  )
  AND l<2
ORDER BY htmlid

<sql:param value = "${param.lang}"/>
<sql:param value = "${nUserId}"/>
<sql:param value = "${nUserId}"/>
<sql:param value = "${nUserId}"/>
<sql:param value = "${nUserId}"/>
</sql:query>


<c:set var="indiv" value="0" />
<c:set var="indetail" value="0" /> 
<c:set var="plang" value="${param.lang}" />
<c:set var="puserid" value="${lUserId}" /> 
<c:set var="psid" value="${param.sid}" /> 

 <!-- Legkulso group-->
 
  <div class="row">
   <div>
    
<c:forEach var="row" items="${result.rows}">
<c:if test = "${row.menulevel == 0}">
   <!--0. menulevel FOMENU ------------------------------------- -->
    <c:if test = "${indiv == 1}">
      <!-- details lezaro -->
       <c:if test="${indetail == 1}">
       </details>
       </td>
       </tr>
       <c:set var="indetail" value="0" /> 
      </c:if> 
      <!-- div lezaro -->
       </table>
       </div>
      </details>
    
    </c:if>
         <details class="panel panel-default">
          <summary class="panel-heading">
          <span class="glyphicon glyphicon-folder-close"></span>
                  <c:out value="${row.txt}"/>
        </summary>   
        <div class="panel-body">
        <table class="table">
        <c:set var="indiv" value="1" />      
  </c:if>
  <c:if test="${row.menulevel == 1 && row.menutype == 0}" >  
      <!-- 1. szint ALMENU LEVELELEM-------------------------------   -->
      <c:if test="${indetail == 1}">
       <!-- details lezaro -->
       </details>
       </td>
       </tr>
       <c:set var="indetail" value="0" /> 
      </c:if>
          <tr>
            <td> 
            
             <a  href="#"  id="<c:out value="${row.idname}"/>" onclick="menuhandler(this,' <c:out value="${param.lang}" />','<c:out value="${nUserId}" />','<c:out value="${param.sid}" />')"><c:out value="${row.txt}"/></a>
           </td>
          </tr> 
    </c:if>
    
   <c:if test="${row.menulevel == 1 && row.menutype == 1}" >  
      <!-- 1. szint ALMENU GYUJTO-------------------------------   -->
          <tr>
          <td> 
          <details>
             <summary><span class="glyphicon glyphicon-list-alt"></span>  <c:out value="${row.txt}"/></summary>
          <c:set var="indetail" value="1" /> 
  </c:if>
   <c:if test="${row.menulevel == 2}" >  
      <!-- 2. szint ALMENU LEVELELEM-------------------------------   -->
          <p class="table" ><a id="<c:out value="${row.idname}"/>" href="#" onclick="menuhandler(this,' <c:out value="${param.lang}" />','<c:out value="${nUserId}" />','<c:out value="${param.sid}" />')"> <c:out value="${row.txt}"/> </a></p>
        
  </c:if>
  
</c:forEach>

<c:if test = "${indiv == 1}">
    <!-- VEGE div lezaro -->
    </table>
    </div>
    </details>
</c:if>

</div>
</div>

