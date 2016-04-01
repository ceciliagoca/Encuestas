<%-- 
    Document   : consultaPracticas
    Created on : 7/05/2014, 11:56:18 AM
    Author     : Cecilia
--%>

 <%@page import="java.util.Iterator"%>
<jsp:useBean id="sem" scope="page" class="ABC.ABCSemestre" />
         
<h1> Resultados de evaluacion de practica </h1>
    
Selecciona semestre:

<%Iterator iter = sem.listarSemestres().iterator(); %>
<select>
    <%while (iter.hasNext()){ %>
    <option value="" onclick="reporte1(<%=(String)iter.next()%>)"><%=(String)iter.next()%></option>
    <%}%>
<!--for each semestra-->
</select> 

<div id="seccGrafica">
 
</div>
    