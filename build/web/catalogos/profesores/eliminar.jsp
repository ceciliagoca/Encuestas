<%-- 
    Document   : eliminar
    Created on : May 29, 2015, 2:16:09 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />

<h1>Eliminar profesor</h1>

<% 
    String rfc = request.getParameter("param");
    profesor = l_profes.getProfesor(rfc);
%>

<img src="imgs/error.png" width="35"> Seguro que desea eliminar al profesor:

 <%= profesor.getTitulo() + " " +  profesor.getNombre() +  " " + profesor.getApeP() + " " + profesor.getApeM()  %>

<center> 
<div style="position: absolute; bottom: 20px; right: 62px;">
            <button class="form_btn" type="button" onclick="frm_eliminarProfesor(<%="'"+rfc+"'"%>)"> Aceptar </button> 
            <button class="form_btn" type="button" onclick="cerrarAux()"> Cancelar </button> 
 
 </div>
</center>

