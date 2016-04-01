<%-- 
    Document   : c1
    Created on : 30/08/2013, 08:26:30 AM
    Author     : Cecilia
--%>

<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

         <jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
         <jsp:useBean id="encuesta" scope="session" class="entity.Encuesta" />
   <jsp:useBean id="abcEnc" scope="session" class="ABC.ABCEncuestas" />
         
       
       
      
        <%
            
            
            
        abcEnc.encuesta.addPregunta( request.getParameter("o_1"), request.getParameter("c_o_1"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_2"), request.getParameter("c_o_2"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_3"), request.getParameter("c_o_3"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_4"), request.getParameter("c_o_4"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_5"), request.getParameter("c_o_5"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_6"), request.getParameter("c_o_6"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_7"), request.getParameter("c_o_7"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_8"), request.getParameter("c_o_8"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_9"), request.getParameter("c_o_9"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_10"), request.getParameter("c_o_10"));
        abcEnc.encuesta.addPregunta( request.getParameter("o_11"), request.getParameter("c_o_11"));  
        abcEnc.encuesta.addPregunta( request.getParameter("o_12"), request.getParameter("c_o_12"));  
        abcEnc.encuesta.addPregunta( request.getParameter("o_13"), request.getParameter("c_o_13"));  
       
        abcEnc.encuesta.addPregunta( "15", request.getParameter("c_o_14"));
        abcEnc.registrarEncuestaServicio();
      
        
       %>

      