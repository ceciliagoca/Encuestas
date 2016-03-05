<%-- 
    Document   : answerBuzon
    Created on : Dec 5, 2014, 5:35:32 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="buzon" scope="session" class="ABC.ABCBuzon" />

<%
 int ibuzon = Integer.parseInt( request.getParameter("buzon"));   
 String answer = request.getParameter("answer");
 
 buzon.sendRespuesta(ibuzon, answer);

%>







