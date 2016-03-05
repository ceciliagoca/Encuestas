
<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />
<h1>Edición de datos de profesor</h1>

<% 
    profesor = l_profes.getProfesor(request.getParameter("param"));
%>

<div class="instrucciones"> Hacer doble click sobre el(los) dato(s) que desea modificar </div>

<form name="n_profesor" id="n_profesor">
    <table class="tabla_editar">
                    <tr>     <td> RFC(sin homoclave):</td> <td id="p_ref"><span style="cursor: default"><%=profesor.getRfc()%></span> <img src="imgs/candado.png" width="20"> </td> </tr>
                    <tr>     <td> Titulo:</td> <td id="p_titulo"> <span  ondblclick="editarCampo('p_titulo', '<%=profesor.getTitulo()%>')"> <%=profesor.getTitulo()%> </span> </td> </tr>
                    <tr>     <td> Nombre:</td> <td id="p_nom"> <span ondblclick="editarCampo('p_nom', '<%=profesor.getNombre()%>')"> <%=profesor.getNombre()%> </span> </td> </tr>
                    <tr>     <td> Apellido paterno:</td> <td id="p_apep"> <span ondblclick="editarCampo('p_apep', '<%=profesor.getApeP()%>')"> <%=profesor.getApeP()%> </span> </td> </tr>
                    <tr>     <td>Apellido materno:</td> <td id="p_apem"> <span ondblclick="editarCampo('p_apem', '<%=profesor.getApeM()%>')"> <%=profesor.getApeM()%> </span> </td> </tr>
                    <tr>     <td>Correo electrónico:</td><td id="p_email"> <span  ondblclick="editarCampo('p_email', '<%=profesor.getCorreo()%>')"> <%=profesor.getCorreo()%> </span> </td> </tr>
                     <tr>    <td>Habilitado: </td>
                   <% if(profesor.getActivo()){ %>
                   <td> <input id="cb_edit_hab" type="checkbox" name="hab"  checked="checked">  
                    <%}%><%else{ %>   <input  id="cb_edit_hab" type="checkbox"  name="hab" >    <%}%>
                    </tr>
                </table>
                
                <center> 
             <div style="position: absolute; bottom: 20px; right: 62px;">
                 <button class="form_btn" type="button" onclick="updateProfesor()"> Aceptar </button> 
            <button class="form_btn" type="button" onclick="cerrarAux()"> Cancelar </button> 
 
 </div>
</center>

            </form>