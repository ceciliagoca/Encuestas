<%-- 
    Document   : cargarGrupos
    Created on : Aug 8, 2014, 3:18:06 PM
    Author     : DIMEI
--%>

<%@page import="ABC.ABCGrupo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 

    String grupos[]= request.getParameterValues("grupo");
    String profesor[]= request.getParameterValues("profesor");
    String cal[]= request.getParameterValues("cal");
    
   ABCGrupo grupo; 
    for(int x=0; x<grupos.length; x++){
        
    grupo = new ABCGrupo(grupos[x], profesor[x], Integer.parseInt(cal[x])); 
    grupo.saveGrupo();
%>
<%="<br>" + grupos[x]%>
<%
}
    %>