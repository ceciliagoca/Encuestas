<%-- 
    Document   : elegirSemestre
    Created on : Jun 14, 2015, 1:11:50 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<form>
    <h1> Elegir semestre: </h1>
 
<label>Año</label> <input type="text" name="semestre"/> 
<label>Periodo</label> <select name="periodo"> <option>1</option>  <option>2</option> </select>

<button type="button" onclick="changeSemenster(this.form);">ir</button>
</form>