<%-- 
    Document   : catAlumnos
    Created on : Jun 26, 2015, 7:40:26 PM
    Author     : DIMEI
--%>
<%@page import="entity.Alumno"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Profesor"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="l_alumnos" scope="page" class="ABC.ABCAlumnos" />
<jsp:useBean id="alumno" scope="page" class="entity.Alumno" />
<!DOCTYPE html>

<h3>Lista de alumnos</h3>

<div class="datagrid">
<table>
<thead><tr><th> Alumno </th><th > brigada </th><th> correo electronico</th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('alumno');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/alumnos/agregar.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar.png" on> <span>Agregar nuevo</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    <%
        int grupo = Integer.parseInt(request.getParameter("param"));
    int idx=0;
    Iterator<Alumno> iter = l_alumnos.listarAlumnos(grupo).iterator();
    while(iter.hasNext()){
alumno = (Alumno)iter.next();
%>

<tr> 
    <td> <span style="cursor:pointer;" onclick="showCMenu(<%=idx%>)">  <%= alumno.getCuenta() +" " +alumno.getApeP() + " " + alumno.getApeM() +  " "+  alumno.getNombre()  %> </span> 
        <div id="c_menu_<%=idx%>" class="c_menu"> 
            <img src="imgs/vermas.png"   onclick="contenidoP('con_div_emergente','catalogos/alumnos/verMas.jsp','<%=alumno.getCuenta()%>'); $('#div_emergente').show();"> 
            <img src="imgs/editar.png"   onclick="contenidoP('con_div_emergente','catalogos/alumnos/editar.jsp','<%=alumno.getCuenta()%>'); $('#div_emergente').show();"> 
            <img src="imgs/eliminar.png" onclick="contenidoP('con_div_emergente','catalogos/alumnos/eliminar.jsp','<%=alumno.getCuenta()%>'); $('#div_emergente').show();"> </div></td>
            <td> <%=(alumno.getBrigada()==0)?"":alumno.getBrigada() %> </td>  <td> <%=alumno.getCorreo() %> </td> 
</tr>


<%
idx++; }%>
</tbody>
</table></div>
