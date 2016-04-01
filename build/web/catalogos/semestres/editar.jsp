
<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />
<%="Edición de datos de profesor"%>

<% 
    profesor = l_profes.getProfesor(request.getParameter("param"));
%>

<form name="n_profesor" id="n_profesor">
                <table>
                    <tr>     <td>RFC(sin homoclave):</td> <td id="p_ref" onclick="editar('p_rfc', '<%=profesor.getRfc()%>')"> <%=profesor.getRfc()%> </td> </tr>
                    <tr>     <td>Nombre:</td> <td> <%=profesor.getNombre()%> </td> </tr>
                    <tr>     <td>Apellido paterno:</td> <td> <%=profesor.getApeP()%> </td> </tr>
                    <tr>     <td>Apellido materno:</td> <td> <%=profesor.getApeM() %> </td> </tr>
                    <tr>     <td>Correo electrónico:</td> <td> <%=profesor.getRfc()%> </td> </tr>
                     <tr>     <td>Habilitado: </td>
                   <% if(profesor.getActivo()){ %>
                   <td> <input type="checkbox" name="hab"  checked="checked">  
                    <%}%><%else{ %>   <input type="checkbox" name="hab" >    <%}%>
                    </tr>
                </table>
                
                <center> <button class="form_btn" type="button" onclick="sendForm(this.form,'control/profesor/nuevo.jsp','con_div_emergente')"> Agregar </button> </center>
            </form>