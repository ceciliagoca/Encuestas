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

%>

<jsp:useBean id="practica" scope="session" class="ABC.ABCPracticas" />


<%=practica.showComentarios(g, p) %>

