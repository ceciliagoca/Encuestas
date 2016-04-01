<%-- 
    Document   : l_alumnosxgrupo
    Created on : Sep 12, 2014, 5:21:07 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="practica" scope="session" class="ABC.ABCPracticas" />

        <%
            int grupo = Integer.parseInt(request.getParameter("param"));
        %>
        <%=practica.listarAlumnosxgrupo(grupo) %>