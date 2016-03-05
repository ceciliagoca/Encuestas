<%-- 
    Document   : listarEncuestasXProfesor
    Created on : Nov 6, 2015, 8:26:56 PM
    Author     : cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
<jsp:useBean id="semestre" scope="session" class="ABC.ABCSemestre" />


<html>
   
    
           <h1>Consulta de encuestas</h1>
           <%@include file="menuVistas.jsp"%>.
           <div id="listCE"> 
        <%=practica.listarEncuestas(cuesUs.getUser(), semestre.getCurrent()) /*por grupo*/ %>
      
         </div>
        
        <div id="showEncuesta" style="display: none">
        
        
        
        </div>
        
    
</html>

