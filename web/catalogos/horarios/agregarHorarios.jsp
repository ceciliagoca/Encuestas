<%-- 
    Document   : agregarProfesor
    Created on : Apr 27, 2015, 5:22:03 PM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>


<div>
    
    <div id="err_mensaje">  </div>
<h1>Nuevo Horario</h1>
        
<form name="n_horario" id="n_profesor">
                <table>
                    <tr>     <td>Descripción</td> <td> <input name="desc" type="text" >  </td> </tr>
                    
                </table>
                
                <center> <button class="form_btn" type="button" onclick="addHorario(this.form)"> Agregar </button> </center>
 </form>
</div>


