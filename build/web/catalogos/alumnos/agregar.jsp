<%-- 
    Document   : agregarProfesor
    Created on : Apr 27, 2015, 5:22:03 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<div>
    
    <div id="err_mensaje">  </div>
<h1>Nuevo alumno</h1>
        
<form name="n_horario" id="n_profesor">
                <table>
                    <tr>     <td>Número de cuenta:</td> <td> <input name="cuenta" type="text" >  </td> </tr>
                    <tr>     <td>Nombre(s):</td> <td> <input type="text"  name="nombre">  </td> </tr>
                    <tr>     <td>Apellido paterno:</td> <td> <input type="text" name="apeP"> </td>  </tr>
                    <tr>     <td>Apellido materno:</td> <td> <input type="text" name="apeM">  </td> </tr>
                  
                    
                </table>
                
                <center> <button class="form_btn" type="button" onclick="addAlumno(this.form, grupo)"> Agregar </button> </center>
 </form>
</div>


