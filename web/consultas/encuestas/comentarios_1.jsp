<%-- 
    Document   : comentarios
    Created on : Oct 8, 2014, 1:57:12 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int g= Integer.parseInt(request.getParameter("grupo"));
        int p= Integer.parseInt(request.getParameter("p"));
        int tipo= Integer.parseInt(request.getParameter("tipo"));

%>

<jsp:useBean id="vcomment" scope="session" class="ABC.ABCComentarios" />


<%=vcomment.showComentarios(g, p, tipo) %>

