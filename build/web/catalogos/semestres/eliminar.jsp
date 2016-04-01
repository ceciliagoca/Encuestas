<%-- 
    Document   : eliminar
    Created on : May 29, 2015, 2:16:09 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />

<%="Eliminar profesor"%>

<% 
    String rfc = request.getParameter("param");
    profesor = l_profes.getProfesor(rfc);
%>

Seguro que desea eliminar al porfesor

<%
   rfc = request.getParameter("param");
   Boolean conf  = request.getParameter("conf").equals("1")?true:false;
   
   l_profes.deleteProfesor(rfc);
   

%>

