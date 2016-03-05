<%-- 
    Document   : promediosPracticas
    Created on : 7/05/2014, 12:55:19 PM
    Author     : Cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="ind" scope="page" class="ABC.Indicadores" />


<% 
   String semestre =  request.getParameter("sem");

    
%>


<h1>Evaluación del semestre</h1>
evaluación 


<jsp:include page="general.jsp" />

<h1>Por grupo </h1>

Grupo:
Profesor:


evaluación 

<h1> Por practica </h1>

Listar practica realizadas
 por 


