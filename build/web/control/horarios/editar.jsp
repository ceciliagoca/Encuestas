<%-- 
    Document   : nuevo
    Created on : May 28, 2015, 12:52:02 AM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<jsp:useBean id="l_horario" scope="page" class="ABC.ABCHorario" />




  <%
  l_horario.editar(Integer.parseInt(request.getParameter("horario")),request.getParameter("pDes") );
  
      
  
  %>

