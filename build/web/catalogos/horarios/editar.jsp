
<jsp:useBean id="l_horario" scope="page" class="ABC.ABCHorario" />
<jsp:useBean id="horario" scope="page" class="entity.Horario" />
<h1>Editar  horario</h1>

<% 
    horario = l_horario.getHorario(Integer.parseInt(request.getParameter("param")));
%>

<div class="instrucciones"> Hacer doble click sobre el(los) dato(s) que desea modificar </div>

<form name="n_horario" id="n_horario">
    <table class="tabla_editar">
                    <tr>     <td> Id:</td> <td id="p_id"><span style="cursor: default"><%=horario.getId()%></span> <img src="imgs/candado.png" width="20"> </td> </tr>
                    <tr>     <td> Descripción:</td> <td id="p_des"><span style="cursor: default" ondblclick="editarCampo('p_des', '<%=horario.getDescripcion()%>')"v><%=horario.getDescripcion()%></span>  </td> </tr>
                    
                </table>
                
                <center> 
             <div style="position: absolute; bottom: 20px; right: 62px;">
                 <button class="form_btn" type="button" onclick="updateHorario()"> Aceptar </button> 
            <button class="form_btn" type="button" onclick="cerrarAux()"> Cancelar </button> 
 
 </div>
</center>

            </form>