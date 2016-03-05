<%-- 
    Document   : listar_alumnosFaltantes
    Created on : Oct 8, 2014, 1:04:00 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />
<%
int grupo = Integer.parseInt(request.getParameter("g"));
int prac= Integer.parseInt(request.getParameter("p"));
      

%>

<%=practica.l_Faltantes_alumnosxpractica(grupo,prac)%>