<%-- 
    Document   : eliminar
    Created on : May 29, 2015, 2:16:09 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<jsp:useBean id="l_horario" scope="page" class="ABC.ABCHorario" />
<jsp:useBean id="horario" scope="page" class="entity.Horario" />

<%   
    int hr = Integer.parseInt(request.getParameter("param"));
    horario = l_horario.getHorario(hr);
%>

<img src="imgs/error.png" width="35"> Se eliminará el siguiente horario:

 <%= horario.getId()+ ". " +  horario.getDescripcion()  %>

<center> 
<div style="position: absolute; bottom: 20px; right: 62px;">
            <button class="form_btn" type="button" onclick="frm_eliminarHorario(<%="'"+horario.getId()+"'"%>)"> Aceptar </button> 
            <button class="form_btn" type="button" onclick="cerrarAux()"> Cancelar </button> 
 
 </div>
</center>

