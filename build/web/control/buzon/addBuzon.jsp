<%-- 
    Document   : addBuzon
    Created on : Aug 22, 2014, 6:15:46 PM
    Author     : DIMEI
--%>

<%@page import="entity.Buzon"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<jsp:useBean id="abcBuzon" scope="page" class="ABC.ABCBuzon" />
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />

<%
Buzon buzon = new Buzon();
buzon.setAlumno(cuesUs.getUser());
buzon.setQueja(request.getParameter("comen"));
buzon.setSeguimiento((request.getParameter("seguir").equals("1")?true:false));

abcBuzon.setBuzon(buzon);
abcBuzon.saveBuzon();

%>