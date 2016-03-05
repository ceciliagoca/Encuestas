<%-- 
    Document   : l_encxalumnos
    Created on : Sep 12, 2014, 6:37:50 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />



        <%
            String t = request.getParameter("t");
            String alu = request.getParameter("param");
            
        %>
        <%if(t.equals("1")){%>
        <%=practica.l_encuestasxalumno(alu)%>
        <%}if(t.equals("2")){%>
        <%=practica.l_encuestasxalumno2(alu)%>
        <%}%>
        
        