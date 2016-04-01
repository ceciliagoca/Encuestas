<%-- 
    Document   : cargarSemestre
    Created on : Aug 6, 2014, 12:34:11 PM
    Author     : DIMEI
--%>

<%@page import="utils.CSV2BD"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="semestr" scope="page" class="ABC.ABCSemestre" />
<!DOCTYPE html>
   <%
       String sem = request.getParameter("sem");
       Date de = Date.valueOf(request.getParameter("de"));
       Date a = Date.valueOf(request.getParameter("a"));
       
       semestr.saveSemestre(sem, de, a);
       CSV2BD file  = new CSV2BD();
       file.cargarCalendarizacion(sem);
        

   
   %>