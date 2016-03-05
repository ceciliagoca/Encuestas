<%@page import="utils.CSV2BD"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.Conexion"%>
<!doctype html>


<html lang="en">
<head>
<meta charset="utf-8">
	<title>Encuestas</title>
    <link rel="stylesheet" href="js/jquery-ui-1.10.3.custom/development-bundle/themes/base/jquery.ui.all.css">
    <script src="js/jquery-ui-1.10.3.custom/development-bundle/jquery-1.9.1.js"></script>
       <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.core.js"></script>
   	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.widget.js"></script>
        <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.position.js"></script>
         <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.tabs.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.mouse.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.button.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.draggable.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.position.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.resizable.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.button.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.dialog.js"></script>
	<script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.effect.js"></script>
        <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.menu.js"></script>
        <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.datepicker.js"></script>
        <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.accordion.js"></script>
        <script src="js/jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.tabs.js"></script>
        <link rel="stylesheet" href="js/jquery-ui-1.10.3.custom/development-bundle/demos/demos.css">
        
        <link rel="stylesheet" href="js/css.css">
        <!link rel="stylesheet" href="js/inicioS.css">
	
        <script src="js/ajax.js"></script>
	<script src="js/validarCuestionarios.js"></script>
        <script src="js/funcionesStylo.js"></script>
        <script src="js/reportes.js"></script>
	<script src="js/inicio.js"></script>
        
        <script src="js/scriptMenu.js"></script>
        <link rel="stylesheet" href="js/stylesMenu.css">
    
</head>


<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
<!jsp:useBean id="auxx" scope="session" class="utils.CSV2BD" />

<% 
    
if(cuesUs!=null)
 session.invalidate(); 
%>
<body>




<div id="encabezado">
        <img src="encabezado.png" style="text-align: center"/>
</div>
  
<div id="divhidden" style="visibility: collapse">
</div>

<div id="div_acceso" title="Acceder a evaluaci&oacute;n" style="display: none">
    
	<p class="validateTips"></p>

        <form id="frmInicio" name="frmInicio ">
	<fieldset>
		<label for="name">Usuario</label>
		<input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
		<label for="password">Contraseña</label>
		<input type="password" name="password" id="password" value="" class="text ui-widget-content ui-corner-all" />
                <a href="m1.pdf" download>Ayuda</a>
        </fieldset>
	</form>

       
</div>

<div id="contraDiv" title="Recuperar contraseña" style="display: none">
    Será enviado a tu correo
	

       
</div>

<div id="div_addUser" title="Agregar usuario"  style="display: none">
    <p class="validateTips"></p>
            <form id="frmAddUser" name="frmAddUser ">
	<fieldset>
                
                <table>
                        <tr><td>Seleccione: </td></tr>
                        <tr><td>Alumno</td><td><input type="radio" name="sel" id="sel1" value="0" onclick="$('#selProfesor').hide();$('#selAlumno').show();"/></td>
                        <td> Profesor </td><td><input type="radio" name="sel" id="sel2" value="1" onclick="$('#selAlumno').hide();$('#selProfesor').show();"/></td></tr>
                </table>
                <div id="selAlumno" style="display: none">
                    <label for="cuenta">Número de cuenta</label>
                    <input type="text" name="cuenta" id="cuenta" class="text ui-widget-content ui-corner-all" />
                    <label for="cuenta">Brigada</label>
                    <input type="text" name="brigada" id="brigada" class="text ui-widget-content ui-corner-all" />
                    <label for="cuenta">Correo electrónico</label>
                    <input type="text" name="emailAlumno" id="emailAlumno" class="text ui-widget-content ui-corner-all" />
                    <label for="passw">Contraseña</label>
                    <input type="password" name="passwAlumno" id="passwAlumno" value="" class="text ui-widget-content ui-corner-all" />
                    <label for="passw1">Contraseña</label>
                    <input type="password" name="passwAlumno1" id="passwAlumno1" value="" class="text ui-widget-content ui-corner-all" />
                </div>
                
                <div id="selProfesor" style="display: none">
                    <label for="cuenta">RFC (sin homoclave)</label>
		    <input type="text" name="profesor" id="profesor" class="text ui-widget-content ui-corner-all" />
                    <label for="cuenta">Correo electrónico</label>
		    <input type="text" name="emailProfe" id="emailProfe" class="text ui-widget-content ui-corner-all" />
                    <label for="passw">Contraseña</label>
                    <input type="password" name="passwProfe" id="passwProfe" value="" class="text ui-widget-content ui-corner-all" />
                    <label for="passw1">Contraseña</label>
                    <input type="password" name="passwProfe" id="passwProfe1" value="" class="text ui-widget-content ui-corner-all" />
                </div>
                
                
		
            </fieldset>
	</form>
        </div>
     <div id="principal" style="display: none">
        
        <div id="c_menu">
            <!jsp:include page="menu.jsp" />
            
        </div>
         
         <div id="div_salir" onclick="contenido('', 'control/cerrar.jsp')">
                <img src="salir.png" height="20" width="20">
                <br>cerrar sesion 
         </div>
         
         <div id="contenido">
        
                <jsp:include page="contenido.jsp" />
         </div>

     
            <div id="div_emergente" >
               <img width="20" src="imgs/cancel.png" 
                    onclick=" $('#div_emergente').hide(); $('#emergente_err_mens').html(''); $('#emergente_err_mens').hide(); $('#con_div_emergente').html('');"  style="left: 89%;  position: relative;   width: 50px; padding-top: 20px;"/>
               <div id="emergente_err_mens"> </div>
               <div id="con_div_emergente"> </div>
            </div>
       
           
          <div id="div_aux_help" style="display:none">
              <img width="20" src="imgs/cancel.png" 
                   onclick="$('#div_aux_help').hide();" style="left: 89%;  position: relative;   width: 50px; padding-top: 20px;"/>
              <div id="con_aux_help"> </div>
        
       
          </div>
         
         </div>






</body>
</html>
