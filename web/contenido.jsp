<%-- 
    Document   : contenido
    Created on : Jan 2, 2014, 8:54:58 PM
    Author     : cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="ABC.ABCUsuarios"%>
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />

<%char tipo = cuesUs.getTipo(); %>

<!-- ienvenido =request.getParameter("tipo") %> Bienvenido =cuesUs.getUser() % -->

<%if(tipo=='1'){
%>
Alumno 





<%}%>

<%if(tipo=='2'){
%>
Profesor
<%}%>


<%if(tipo=='3'){%>
        
       <div id="cajaIndicador" class="cajaIndicador">
           
          
       </div>
        

<%}%>

<div id="menu"> </div>