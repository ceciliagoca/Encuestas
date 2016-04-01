<%-- 
    Document   : buzon
    Created on : Sep 26, 2014, 12:23:22 PM
    Author     : DIMEI
--%>
<jsp:useBean id="buzon" scope="page" class="ABC.ABCBuzon" />

<h1>BUZ&Oacute;N</h1>

<h2> Buz&oacute;n de alumnos </h2>

<table class="tabla">
    <thead> <td width ='60'>Folio</td> <td width ='80'>Fecha </td> <td width ='80'>No. Cuenta </td> <td width='200'>Nombre </td> <td width='18'> </td></thead>


 
    
<%=buzon.viewBuzonAlumnos(request.getParameter("param"))%>


</table>

<h2> Buz&oacute;n de profesores </h2>

<div id="showComment" style="display: none">

   
</div>