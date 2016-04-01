<%-- 
    Document   : catProfesores
    Created on : Apr 24, 2015, 12:44:10 AM
    Author     : DIMEI
--%>

<%@page import="entity.Horario"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Profesor"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="l_horarios" scope="page" class="ABC.ABCHorario" />
<jsp:useBean id="horario" scope="page" class="entity.Horario" />
<!DOCTYPE html>

<h3>Horarios</h3>

<div class="datagrid">
<table>
<thead><tr><th> Horario </th><th > descripción</th></tr></thead>
<tfoot><tr><td colspan="2">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('horario');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/horarios/agregarHorarios.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar2.png" on> <span>Agregar nuevo</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    

<%
    int idx=0;
    Iterator<Horario> iter = l_horarios.listarHorarios().iterator();
    while(iter.hasNext()){
    horario = (Horario)iter.next();
%>

<tr> 
    <td> <span style="cursor:pointer;" onclick="showCMenu(<%=idx%>)">  <%= horario.getId() %> </span> 
        <div id="c_menu_<%=idx%>" class="c_menu"> 
            <img src="imgs/editar_.png"   onclick="contenidoP('con_div_emergente','catalogos/horarios/editar.jsp','<%=horario.getId()%>'); $('#div_emergente').show();"> 
            <img src="imgs/eliminar_.png" onclick="contenidoP('con_div_emergente','catalogos/horarios/eliminar.jsp','<%=horario.getId()%>'); $('#div_emergente').show();"> </div></td> 
            
    <td><%=  horario.getDescripcion()%> </td>        
</tr>
<%
idx++; }%>

</tbody>
</table></div>
