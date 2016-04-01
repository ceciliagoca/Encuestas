<%-- 
    Document   : catProfesores
    Created on : Apr 24, 2015, 12:44:10 AM
    Author     : DIMEI
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Profesor"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />
<!DOCTYPE html>

<h3>Profesores</h3>

<div class="datagrid">
<table>
<thead><tr><th> Profesor</th><th >correo electrónico</th><th>activo</th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('profesor');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/profesores/agregarProfesor.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar.png" on> <span>Agregar nuevo</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    

<%
    int idx=0;
    Iterator<Profesor> iter = l_profes.listarProfesores().iterator();
    while(iter.hasNext()){
    profesor = (Profesor)iter.next();
%>

<tr> 
    <td> <span style="cursor:pointer;" onclick="showCMenu(<%=idx%>)">  <%= profesor.getTitulo() + " "+  profesor.getNombre() +" " +profesor.getApeP() + " " + profesor.getApeM() %> </span> 
        <div id="c_menu_<%=idx%>" class="c_menu"> 
            <img src="imgs/vermas.png"   onclick="contenidoP('con_div_emergente','catalogos/profesores/verMas.jsp','<%=profesor.getRfc()%>'); $('#div_emergente').show();"> 
            <img src="imgs/editar.png"   onclick="contenidoP('con_div_emergente','catalogos/profesores/editar.jsp','<%=profesor.getRfc()%>'); $('#div_emergente').show();"> 
            <img src="imgs/eliminar.png" onclick="contenidoP('con_div_emergente','catalogos/profesores/eliminar.jsp','<%=profesor.getRfc()%>'); $('#div_emergente').show();"> </div></td> <td> <%=profesor.getCorreo() %> </td>  <td> <%=(profesor.getActivo())?"Sí":"No"%> </td> 
</tr>
<%
idx++; }%>

</tbody>
</table></div>
