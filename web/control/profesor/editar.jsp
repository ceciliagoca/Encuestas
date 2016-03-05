<%-- 
    Document   : nuevo
    Created on : May 28, 2015, 12:52:02 AM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<jsp:useBean id="profesor" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="_profesor" scope="page" class="entity.Profesor" />


  <%
      _profesor.setTitulo(request.getParameter("titulo"));
      _profesor.setNombre(request.getParameter("nombre"));
      _profesor.setApeP(request.getParameter("apeP"));
      _profesor.setApeM(request.getParameter("apeM"));
      _profesor.setCorreo(request.getParameter("email"));
      Boolean habilitado = request.getParameter("hab").equals("on")?true:false;
      _profesor.serActivo(habilitado);
      _profesor.setRfc(request.getParameter("rfc"));
     
      
      
      profesor.editProfesor(_profesor);
      
  
  %>

