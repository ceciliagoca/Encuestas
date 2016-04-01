<%-- 
    Document   : eliminar
    Created on : Jul 29, 2015, 6:03:18 PM
    Author     : cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="profesor" scope="page" class="ABC.ABCProfesores" />


  <%
      String rfc = request.getParameter("rfc");
       profesor.deleteProfesor(rfc);
  
  %>

  <%=rfc%>