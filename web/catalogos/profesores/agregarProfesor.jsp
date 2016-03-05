<%-- 
    Document   : agregarProfesor
    Created on : Apr 27, 2015, 5:22:03 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<div>
    
    <div id="err_mensaje">  </div>
<h1>Nuevo Profesor</h1>
        
<form name="n_profesor" id="n_profesor">
                <table>
                    <tr>     <td>RFC(sin homoclave):</td> <td> <input name="rfc" type="text" >  </td> </tr>
                    <tr>     <td>Titulo: </td> <td> <select name="titulo">  <option value=""></option> <option value="M.I.">M.I.</option>  <option value="Mtr.">Mtr.</option> <option value="Ing.">Ing.</option> </select>  </td> </tr>
                    <tr>     <td>Nombre(s):</td> <td> <input type="text"  name="nombre">  </td> </tr>
                    <tr>     <td>Apellido paterno:</td> <td> <input type="text" name="apeP"> </td>  </tr>
                    <tr>     <td>Apellido materno:</td> <td> <input type="text" name="apeM">  </td> </tr>
                    <tr>     <td>Habilitado:</td> <td> <input type="checkbox" name="hab" value="1">  </td> </tr>
                    
                </table>
                
                <center> <button class="form_btn" type="button" onclick="addProfesor(this.form)"> Agregar </button> </center>
 </form>
</div>


