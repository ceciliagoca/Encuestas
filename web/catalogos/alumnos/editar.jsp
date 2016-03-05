
<jsp:useBean id="l_practica" scope="page" class="ABC.ABCPracticas" />
<jsp:useBean id="practica" scope="page" class="entity.Practica" />
<h1>Editar  práctica</h1>

<% 
    practica = l_practica.getPractica(Integer.parseInt(request.getParameter("param")));
%>

<div class="instrucciones"> Hacer doble click sobre el(los) dato(s) que desea modificar </div>

<form name="n_horario" id="n_horario">
    <table class="tabla_editar">
                    <tr>     <td> Id: </td> <td id="p_id"><span style="cursor: default"><%=practica.getId()%></span> <img src="imgs/candado.png" width="20"> </td> </tr>
                    <tr>     <td> Nombre: </td> <td id="p_des"><span style="cursor: default" ondblclick="editarCampo('p_des', '<%=practica.getName()%>')"v><%=practica.getName()%></span>  </td> </tr>
                    <tr>     <td> Tipo: </td> <td id="p_tipo">  <select name="cb_p_tipo" id="cb_p_tipo"> <option>Evaluación de pactica</option> <option>Evaluación de servicio </option> </select> </span>  </td> </tr>
                    
                </table>
                
                <center> 
             <div style="position: absolute; bottom: 20px; right: 62px;">
                 <button class="form_btn" type="button" onclick="updatePractica()"> Aceptar </button> 
            <button class="form_btn" type="button" onclick="cerrarAux()"> Cancelar </button> 
 
 </div>
</center>

            </form>