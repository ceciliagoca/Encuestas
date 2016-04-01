<%-- 
    Document   : catPRacticas
    Created on : Apr 24, 2015, 12:44:10 AM
    Author     : DIMEI
--%>

<%@page import="entity.Practica"%>
<%@page import="entity.Horario"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Profesor"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="l_practicas" scope="page" class="ABC.ABCPracticas" />
<jsp:useBean id="praticas" scope="page" class="entity.Practica" />
<!DOCTYPE html>

<h3>Lista de prácticas</h3>

<div class="datagrid">
<table>
<thead><tr><th> Clave de práctica </th><th > Nombre </th> <th > Tipo </th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('practicas');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/practicas/agregarPractica.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar2.png" on> <span>Agregar nuevo</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    

<%
    int idx=0;
    Iterator<Practica> iter = l_practicas.listarPracticas().iterator();
    while(iter.hasNext()){
    praticas = (Practica)iter.next();
%>

<tr> 
    <td> <span style="cursor:pointer;" onclick="showCMenu(<%=idx%>)">  <%= praticas.getId() %> </span> 
        <div id="c_menu_<%=idx%>" class="c_menu"> 
            <img src="imgs/editar_.png"   onclick="contenidoP('con_div_emergente','catalogos/practicas/editar.jsp','<%=praticas.getId()%>'); $('#div_emergente').show();"> 
            <img src="imgs/eliminar_.png" onclick="contenidoP('con_div_emergente','catalogos/practicas/eliminar.jsp','<%=praticas.getId()%>'); $('#div_emergente').show();"> </div></td> 
            
    <td><%=  praticas.getName()%> </td> <td>  <%=(praticas.getTipo()=='A')? "evaluación de practica" : " evaluación de servicio"  %> </td>        
</tr>

<%
idx++; }%>
</tbody>
</table></div>

