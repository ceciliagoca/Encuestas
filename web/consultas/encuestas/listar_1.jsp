<%-- 
    Document   : listar
    Created on : 4/04/2014, 01:25:24 PM
    Author     : Cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
           <h1>Consulta de encuestas</h1>
           <%@include file="menuVistas.jsp"%>.
           <div id="listCE"> 
               <%String semestre =  request.getParameter("param"); %>
        <%=practica.listarEncuestas(semestre)  %>
      
         </div>
        
        <div id="showEncuesta" style="display: none">
        
        
        
        </div>
        
    </body>
</html>
