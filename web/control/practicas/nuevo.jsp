<%-- 
    Document   : nuevo
    Created on : May 28, 2015, 12:52:02 AM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<jsp:useBean id="practicas" scope="page" class="ABC.ABCPracticas" />


  

  <%
      
      practicas.nueva(request.getParameter("name"), request.getParameter("tipo"));
  %>
