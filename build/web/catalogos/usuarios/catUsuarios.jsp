<%-- 
    Document   : catUsuarios
    Created on : Jun 26, 2015, 7:38:24 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="entity.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>



<jsp:useBean id="l_usuarios" scope="page" class="ABC.ABCUsuarios" />
<jsp:useBean id="usuario" scope="page" class="entity.Usuario" />
<!DOCTYPE html>

<h1>Usuarios</h1>


<h3>Buscar usuaurios<h3>

<h3>Subir usuarios<h3>


<h3>Administradores</h3>


<div class="datagrid">
<table>
<thead><tr><th> Nombre </th><th > usuario </th><th> correo electronico</th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('alumno');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/alumnos/agregar.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar.png" on> <span>Agregar usuario de administrador</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    <% /*
        int grupo = Integer.parseInt(request.getParameter("param"));
    int idx=0;
    Iterator<Alumno> iter = l_alumnos.listarAlumnos(grupo).iterator();
    while(iter.hasNext()){
alumno = (Alumno)iter.next();
            
            */
%>

<tr> 
   
</tr>


<%
//idx++; }%>
</tbody>
</table></div>




<h3>Profesores</h3>


<div class="datagrid">
<table>
<thead><tr><th> Nombre </th><th > usuario </th><th> correo electronico</th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('alumno');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/alumnos/agregar.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar.png" on> <span>Agregar usuario de administrador</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    <% /*
        int grupo = Integer.parseInt(request.getParameter("param"));
    int idx=0;
    Iterator<Alumno> iter = l_alumnos.listarAlumnos(grupo).iterator();
    while(iter.hasNext()){
alumno = (Alumno)iter.next();
            
            */
%>

<tr> 
   
</tr>


<%
//idx++; }%>
</tbody>
</table></div>





<h3>Administradores</h3>


<div class="datagrid">
<table>
<thead><tr><th> Nombre </th><th > usuario </th><th> correo electronico</th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20px" src="imgs/info.png" onclick="showInfo('alumno');"> 
                        <a href="#" onclick=" $('#emergente_err_mens').html(''); contenido('con_div_emergente','catalogos/alumnos/agregar.jsp'); $('#div_emergente').show();">
                    <img width="20px"  src="imgs/agregar.png" on> <span>Agregar usuario de administrador</span> </a> 
                    </li></ul></div>
        </td></tr></tfoot>
<tbody>
    <% /*
        int grupo = Integer.parseInt(request.getParameter("param"));
    int idx=0;
    Iterator<Alumno> iter = l_alumnos.listarAlumnos(grupo).iterator();
    while(iter.hasNext()){
alumno = (Alumno)iter.next();
            
            */
%>

<tr> 
   
</tr>


<%
//idx++; }%>
</tbody>
</table></div>



