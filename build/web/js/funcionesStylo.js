/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function cerrarAux(){
    $('#emergente_err_mens').html("");
    $('#con_div_emergente').html("");
    $("#div_emergente").hide();
}


function abrirIndices(){
contenido('principal','indicadores.jsp');
}

function validarForm(frm){
   
    var chek = frm.elements[0].value;
  alert(chek);
   if( ch.vale < 10 ){alert("te pedimos de favor que nos ayudes a mejorar el servicio y agregues comentarios en las preguntas donde tu evalución no fue completament satisfactoria. Gracias!");
   }
   
    }
    
 function f_menu(n){
    
   vfrom = "#from"+n;
   vto = "#to"+n;
    
    
    $( vfrom ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			onClose: function( selectedDate ) {
				$( vto ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$( vto ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			onClose: function( selectedDate ) {
				$( vfrom ).datepicker( "option", "maxDate", selectedDate );
			}
		});
    
}

function subirCalendarizacion(){
    // envio de calendario
   
    sendFile('archivoCal','control/calendario/cargarCalendario.jsp');
    a = $("#cfrom").val().split("/");
  from = a[2]+'-'+a[0]+'-'+a[1];
   a = $("#cto").val().split("/");
     to = a[2]+'-'+a[0]+'-'+a[1];
    info = 'sem='+ $("#t_semestre").val() + "&de="+ from+ "&a="  +to;
    //alert(info);
    pasarParamertros('control/calendario/cargarSemestre.jsp',info);
    
    
    
   
    contenido('contenido','catalogos/iniciarSistema2.jsp');
    alert('Se ha cargado exitosamente la calendarizacion, por favor continue');
    $('#i_2').hide(); $('#i_3').show();
    
}

function l_alumnosDe(x){
     
     contenidoP('g_'+x,'consultas/encuestas/l_alumnosxgrupo.jsp',x);
      $('#g_'+x).show();
      
      document.getElementById("bt_"+x).innerHTML="<img src='imgs/down.png'  style='cursor:pointer' onclick='d_alumnosDe(" + x +");'>";
}

function d_alumnosDe(x){
     
      $('#g_'+x).hide();
      document.getElementById("bt_"+x).innerHTML="<img src='imgs/up.png' style='cursor:pointer' onclick='l_alumnosDe(" + x +");'>";

}

function l_practicasDe(x){
    p=x+"&t=1"
    contenidoP('a_'+x,'consultas/encuestas/l_encxalumnos.jsp',p);
    $('#a_'+x).show();
    document.getElementById("bt_"+x).innerHTML="<img src='imgs/down.png' width='20px'  style='cursor:pointer' onclick='d_practicasDe(" + x +");'>";
}   


function d_practicasDe(x){
     
      $('#a_'+x).hide();
      document.getElementById("bt_"+x).innerHTML="<img src='imgs/up.png' width='20px' style='cursor:pointer' onclick='l_practicasDe(" + x +");'>";

}

function showEncuesta(x,t){
    if(t=='A')   contenidoP('showEncuesta','consultas/encuestas/c_forma1.jsp',x);
     else   contenidoP('showEncuesta','consultas/encuestas/c_forma2.jsp',x);
     $("#showEncuesta").show();
}

function showComment(x){
     contenidoP('showComment','consultas/buzon/3/comment.jsp',x);
     $("#showComment").show();
}



 function searchByAlumn(x){

     ban=true;
    $('#txt_ncuenta').on('keydown', function(e) {
    if (e.keyCode== 13 && ban ) {
        ban=false;
        alum = $('#txt_ncuenta').val();
        param= "param="+alum+"&t=2";
                
                
            pasarParamertros("consultas/encuestas/l_encxalumnos.jsp",param);
        
       setTimeout (function(){
       
        res = ajax_res;
       
        if (res.search('_cod_0_')  != -1) alert('alumno no encontrado'); 
        else if (res.search('_cod_1_') != -1 ) alert('el alumno no tiene encuestas contestadas');
        else{
                document.getElementById('contenido').innerHTML=res;
        } 
       
       
       
       }, 1000);
        
         
         
    }
});
 }
 
 
  function entrar(){

   // alert('entre');
     //ban=true;
    $('#password').on('keydown', function(e) {
    if (e.keyCode== 13 /* && ban*/ ) {
    
      // alert('s1');     
       var name = $("#name"), password = $("#password");
       allFields = $([]).add(name).add(password);
       tips = $( ".validateTips" );
     
        if(name.val().length===0 || password.val().length===0 ){
                updateTips( "Datos invalidos");
		}else{
                    var forma = "name=" + name.val() + "&passwd=" + password.val();
                  
                    
                    x =0;
                    var xmlhttp = myOAjax();
                    xmlhttp.open("POST","control/inicioSesion.jsp",true)
                    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
                    xmlhttp.send(forma);
				xmlhttp.onreadystatechange=function(){
                        if (xmlhttp.readyState==4 && xmlhttp.status==200){
                            x=xmlhttp.responseText;
                          
                        }
                        
                    };
			
                    setTimeout(function() {
                        if (x != 0) {
                        $("#div_acceso").dialog("close");
                        sendForm("tipo="+x,"contenido.jsp","contenido");
                        sendForm("tipo="+x,"menu.jsp","menu");
                        $('#principal').show('slow');
                        $("c_menu").menu();
                        } else {
                          updateTips( "Datos invalidos");
                        }

                    }, 1000 );

                }
     
      
    }
});
 }
 
//consulta de faltnates


function l_practicasF_De(x){
    
    $('#g_'+x).show();
    document.getElementById("bt_"+x).innerHTML="<img src='imgs/down.png'  style='cursor:pointer' onclick='d_practicasF(" + x +");'>";
}   


function d_practicasF(x){
     
      $('#g_'+x).hide();
      document.getElementById("bt_"+x).innerHTML="<img src='imgs/up.png'Re  style='cursor:pointer' onclick='l_practicasF_De(" + x +");'>";

}

function l_alumnosF(practica, grupo){
    
    p="&g="+grupo+"&p="+practica;
    contenidoP('a_'+practica+'_'+grupo,'consultas/encuestas/listar_alumnosFaltantes.jsp',p);
    $('#a_'+practica+'_'+grupo).show();
    document.getElementById("bt_"+practica+'_'+grupo).innerHTML="<img src='imgs/down.png' width='20px'  style='cursor:pointer' onclick='d_alumnosF(" + practica +", "+ grupo+ ");'>";
}

function d_alumnosF(x,y){
     
      $('#a_'+x+'_'+y).hide();
      document.getElementById("bt_"+x+'_'+y).innerHTML="<img src='imgs/up.png' width='20px'  style='cursor:pointer' onclick='l_alumnosF(" + x+","+y+ ");'>";

}

function showAmumnoNo(){
     $('#alumnoNo').show();
     document.getElementById("bt_alumnoN").innerHTML="<img src='imgs/down.png'  style='cursor:pointer' onclick='hideAmumnoNo();'>";
}

function hideAmumnoNo(){
     $('#alumnoNo').hide();
      document.getElementById("bt_alumnoN").innerHTML="<img src='imgs/up.png'  style='cursor:pointer' onclick='showAmumnoNo();'>";
    
}

function vistaComentarios(tipo){

    $( "#contenido" ).hide();
     contenidoP('contenido','consultas/encuestas/comentarios.jsp',tipo);
     
     setTimeout (function(){
       $( "#accordion" ).accordion({collapsible: true});
         $( "#accordion" ).accordion( "option", "heightStyle", "content"  );
         
       
        
       
         $( "#contenido" ).show();
       }, 800);
   
}

function vistaComentarios(tipo,semestre){
semestre = $.trim( semestre );
    $( "#contenido" ).hide();
     contenidoP('contenido','consultas/encuestas/comentarios_anteriores.jsp',tipo+'&sem='+semestre);
     
     setTimeout (function(){
       $( "#accordion" ).accordion({collapsible: true});
         $( "#accordion" ).accordion( "option", "heightStyle", "content"  );
         
       
        
       
         $( "#contenido" ).show();
       }, 800);
   
}


function vistaComentariosGrupo(tipo,semestre,grupo){

    semestre = $.trim( semestre );
    $( "#contenido" ).hide();
     contenidoP('contenido','consultas/encuestas/comentariosGrupo.jsp',tipo+'&sem='+semestre+'&grupo='+grupo);
     
     setTimeout (function(){
       $( "#accordion" ).accordion({collapsible: true});
         $( "#accordion" ).accordion( "option", "heightStyle", "content"  );
         
       
        
       
         $( "#contenido" ).show();
       }, 800);
   
}

function chargeComments(grupo,p,tipo){
    x = (tipo=='A')?'1':'2';
    param= "x&grupo="+grupo + "&p="+p+"&tipo="+x;
    vars_ = grupo +"_"+p;
    contenidoP("g_"+vars_,'consultas/encuestas/comentarios_1.jsp',param);
    showComents(grupo,p);
    
}

function showComents(grupo, p){
      vars_ = grupo +"_"+p;
      document.getElementById("bt_"+vars_).innerHTML="<img src='imgs/down.png' width='20px'  style='cursor:pointer' onclick='hideComents(" + grupo+","+p+ ");'>";
        $("#g_" + vars_).show();
}


function hideComents(grupo,p){
      document.getElementById("bt_"+grupo+'_'+p).innerHTML="<img src='imgs/up.png' width='20px'  style='cursor:pointer' onclick='showComents(" + grupo+","+p+ ");'>";
      $('#g_'+grupo+'_'+p).hide();
      

}

function vistaResumenPracticas(semestre){
semestre = $.trim( semestre );
     contenidoP('contenido','consultas/reportes/promediosPracticas.jsp','&sem='+semestre);
     
   
   
}


function answerBuzon(buzon){
    
    
 
    param  =  "buzon=" + buzon + "&answer=" +  $('#answearBuzon').val();
    pasarParamertros('control/buzon/answerBuzon.jsp', param);
    alert("Mensaje enviado ");
    
    
    //cerrar ventana
   $('#showComment').hide();
    //actualizar vista de buzon
    contenido('contenido','consultas/buzon/buzon.jsp');
    
}

function infoProfesor(profesor){
    //seccion, pagina, paramentro
    contenidoP('emergente','catalogos/control/profesores/ficha.jsp', profesor);
    $('emeregente').show();
    
}
function showCMenu(a){
   if( $('#c_menu_'+a).is(':hidden') )
    $('#c_menu_'+a).show();
    else   $('#c_menu_'+a).hide();
    
    
}

function showInfo(opcion){
    text="";
    if(opcion == 'profesor')
    text = "<h3>Instrucciones</h3> Dar click en los nombres de los profesores para poder:  <br> <img src='imgs/vermas.png' width='20'> Ver m\u00e1s informaci\u00f3n <br> <img src='imgs/editar.png' width='20'> Editar <br> <img src='imgs/eliminar.png' width='20'> Eliminar  <br> con un segundo click se ocultar\u00e1 el men\u00fa. Para agregar un nuevo profesor usar el bot\u00f3n <img src='imgs/agregar.png' width='20'> ubicado en la parte inferior derecha";
        document.getElementById('con_aux_help').innerHTML = text;
        $('#div_aux_help').show();
        
            if(opcion == 'usuario')
    text = "<h3>Instrucciones</h3> Dar click en los nombres de los usuario para poder:  <br> <img src='imgs/vermas.png' width='20'> Ver m\u00e1s informaci\u00f3n <br> <img src='imgs/editar.png' width='20'> Editar <br> <img src='imgs/eliminar.png' width='20'> Eliminar  <br> con un segundo click se ocultar\u00e1 el men\u00fa. Para agregar un nuevo usuario usar el bot\u00f3n <img src='imgs/agregar.png' width='20'> ubicado en la parte inferior derecha";
        document.getElementById('con_aux_help').innerHTML = text;
        $('#div_aux_help').show();
        
     if(opcion == 'semestre')
    text = "<h3>Instrucciones</h3> Este catalogo lista los semestres registrados en el sistema. Dar click en el semestre para poder:  <br> <img src='imgs/vermas.png' width='20'> Ver m\u00e1s informaci\u00f3n <br> con un segundo click sobre el semestre se ocultar\u00e1 el men\u00fa. Para agregar un nuevo semestre usar el bot\u00f3n <img src='imgs/agregar2.png' width='20'> ubicado en la parte inferior derecha";
        document.getElementById('con_aux_help').innerHTML = text;
        $('#div_aux_help').show();    
        
             if(opcion == 'horario')
    text = "<h3>Instrucciones</h3> Este catalogo lista los horarios registrados en el sistema. Dar click en la clave del horario para poder:  <br> <img src='imgs/editar_.png' width='20'> Editar <br> <img src='imgs/eliminar_.png' width='20'> Eliminar  <br> Con un segundo click en la clave se ocultar\u00e1 el men\u00fa. Para agregar un nuevo horario usar el bot\u00f3n <img src='imgs/agregar2.png' width='20'> ubicado en la parte inferior derecha";
        document.getElementById('con_aux_help').innerHTML = text;
        $('#div_aux_help').show();   
        
                  if(opcion == 'practicas')
    text = "<h3>Instrucciones</h3> Este catalogo lista de pr\u00e1cticas registrados en el sistema. Dar click en la clave de la pr\u00e1ctica para poder:  <br> <img src='imgs/editar_.png' width='20'> Editar <br> <img src='imgs/eliminar_.png' width='20'> Eliminar  <br> Con un segundo click en la clave se ocultar\u00e1 el men\u00fa. Para agregar una nueva practica  usar el bot\u00f3n <img src='imgs/agregar2.png' width='20'> ubicado en la parte inferior derecha";
        document.getElementById('con_aux_help').innerHTML = text;
        $('#div_aux_help').show();   
        
    
    
}

var aux_edit=true;
function editarCampo(campo, valor){
   
 $('#'+campo).html("<input type='text'  name='"+campo+"' onblur=\"editvalue('" + campo+ "');\"   value='"+valor+"'>");
     aux_edit=false;
}

function editvalue(campo){
valor= $("input[name="+campo+"]").val();
      aux_edit=true;
      $('#'+campo).html("<span ondblclick=\"editarCampo('"+campo+"', '"+valor+"')\"> "+valor+"</span>");
    
}

function changeSemenster(form){
    var sem = "sem=" + form.elements['semestre'].value + '-'+  form.elements['periodo'].value;
                          
                           
                            sendCadena(sem,'menu.jsp', 'c_menu');
                           
                            setTimeout(function() { 
                                menu();
                                $('#principal').show('slow');
                            },400);
                            
                            contenido("contenido", "contenido.jsp");
                            
}


function cargarSemestre(s_sem){
    var sem = "sem=" + s_sem;
                            sendCadena(sem,'menu.jsp', 'c_menu');
                           
                            setTimeout(function() { 
                                menu();
                                $('#principal').show('slow');
                            },400);
                            
                            contenido("contenido", "contenido.jsp");
                            
}


function mostrarAlumnos(grupo){
    
//abrir grupo    
  contenidoP('contenido','catalogos/alumnos/catAlumnos.jsp', grupo);
}

function showResumenGrupo(grupo){
    
    contenidoP('contenido','consultas/encuestas/resumenEvaluacionPracticasXGrupo.jsp', grupo);
}
