<%-- 
    Document   : indicadores
    Created on : Mar 13, 2015, 8:15:26 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="ind" scope="page" class="entity.Indicadores" />

<h3>Objetivos de calidad</h3> 
<ul>
<li> 1. <%=ind.iservicio(1) %></li>
<li> 2. <%=ind.iservicio(1) %></li>
</ul>
<h3> Proceso de realización </h3> 
<ul>
<li> 10. <%=ind.iservicio(10) %></li>
<li> 12. <%=ind.iservicio(12) %></li>
<li> 13. <%=ind.iservicio(13) %></li>
<li> 14. <%=ind.iservicio(14) %></li>
<li> 15. <%=ind.iservicio(15) %></li>
</ul>
