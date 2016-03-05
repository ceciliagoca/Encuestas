<%-- 
    Document   : eliminar
    Created on : Jul 29, 2015, 6:03:18 PM
    Author     : cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="practicas" scope="page" class="ABC.ABCPracticas" />


  <%
      
      practicas.eliminar(Integer.parseInt(request.getParameter("practica")));
  %>
