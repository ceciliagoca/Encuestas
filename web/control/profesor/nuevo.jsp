<%-- 
    Document   : nuevo
    Created on : May 28, 2015, 12:52:02 AM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<jsp:useBean id="profesor" scope="page" class="ABC.ABCProfesores" />


  <%
      String titulo = request.getParameter("titulo");
      String nombre = request.getParameter("nombre");
      String apeP = request.getParameter("apeP");
      String apeM = request.getParameter("apeM");
      Boolean habilitado = request.getParameter("hab").equals("1")?true:false;
      String rfc = request.getParameter("rfc");
     
      
      
      profesor.addProfesor(rfc,titulo,nombre,apeP,apeM,habilitado);
      
  
  %>

<%=nombre + apeM + apeP %>