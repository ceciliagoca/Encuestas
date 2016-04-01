<%-- 
    Document   : alumnos_faltantes
    Created on : Oct 5, 2014, 9:38:31 PM
    Author     : DIMEI
--%>
<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />


      <h1>Alumnos que no han contestado</h1>
           
     <%@include file="menuVistas.jsp"%>.
           <div id="listCE"> 
               <%=practica.listarFaltantes()%>
      
         </div>
        
        <div id="showEncuesta" style="display: none"> </div>
        
        
<h1> <span id="bt_alumnoN"><img src='imgs/up.png' onclick="showAmumnoNo();"> </span>>Alumnos que no se han registrado al sistema</h1>
     
<div id="alumnoNo" style="display: none">
           <%=practica.alumnosNoRegistrados() %>
         </div>
       
        