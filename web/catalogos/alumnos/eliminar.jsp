<%-- 
    Document   : eliminar
    Created on : May 29, 2015, 2:16:09 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<jsp:useBean id="l_practica" scope="page" class="ABC.ABCPracticas" />
<jsp:useBean id="practica" scope="page" class="entity.Practica" />

<%   
    int hr = Integer.parseInt(request.getParameter("param"));
    practica = l_practica.getPractica(Integer.parseInt(request.getParameter("param")));
    
%>

<img src="imgs/error.png" width="35"> Se eliminará la siguiente practica:

 <%= practica.getId()+ ". " +  practica.getName() %>

<center> 
<div style="position: absolute; bottom: 20px; right: 62px;">
            <button class="form_btn" type="button" onclick="frm_eliminarPractica(<%="'"+practica.getId()+"'"%>)"> Aceptar </button> 
            <button class="form_btn" type="button" onclick="cerrarAux()"> Cancelar </button> 
 
 </div>
</center>

