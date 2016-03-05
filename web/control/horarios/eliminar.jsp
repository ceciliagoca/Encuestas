<%-- 
    Document   : eliminar
    Created on : Jul 29, 2015, 6:03:18 PM
    Author     : cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="horario" scope="page" class="ABC.ABCHorario" />


  <%
       
       horario.eliminar(Integer.parseInt(request.getParameter("hr")));
  
  %>
