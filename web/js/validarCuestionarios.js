banValido = false;
//var myVal = new Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true);
//var myVal2 = new Array(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);

var myVal = new Array(false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false);



function enviarForm(form, tipo) {
    i = 0;
    
   
    valido = true;

   
    
     if(tipo=='s'){
     
       myVal.forEach(function(entry) {
     valido = (valido && entry)? true : false;
     });
     
     if (valido){
         
        sendForm(form, 'control/encuestas/c2.jsp', 'contenido');
        setTimeout(function() {
            contenido("c_menu", "menu.jsp");
        }, 1000);
     
    alert("Encuesta enviada correctamente");
     }else{
     alert("Corrige");
     }
     
     }else{
     
    
     myVal.forEach(function(entry) {
     valido = (valido && entry)? true : false;
     });
     
     if (valido){
         
        sendForm(form, 'control/encuestas/c1.jsp', 'contenido');
        setTimeout(function() {
            contenido("c_menu", "menu.jsp");
        }, 1000);
     
    alert("Encuesta enviada correctamente");
     }else{
     alert("Corrige");
     }
     
     } 
     
    
}

function mostrarForm(param, tipo) {
    banVailido = true;
    if (tipo == 'A') {
        contenidoP('contenido', 'forma1.jsp', param);
        setTimeout(function() {
            val1(); 
       

        }, 1000);
    }

    if (tipo == 'B') {
        contenidoP('contenido', 'forma2.jsp', param);
          setTimeout(function() {
            myVal[14]=true;  myVal[15]=true;  myVal[16]=true;  myVal[17]=true;
             val2(); 

        }, 1000);
    }

}



/*
 * valida que el usuario escriba comentarios si evalua con mennos de 8 
 * en las preguntas 1 - 10 y 13 de la evaluacion de practicas
 */

function val1() {

    vComenOnBlur();
    $("input:radio").click(function() {
        objthis = $(this);
        oname = objthis.attr("name");
        i_ = oname.indexOf('_');
        ind = oname.substring(i_ + 1, oname.length);


        if (ind < 11 || ind == 17) {

            vCalificacion(objthis, ind);

        }

        if (ind > 10 && ind < 15) {
            if( objthis.is(":checked"))
                myVal[ind - 1] = true;
             sumE = $("input[name=o_11]:radio:checked").val() + $("input[name=o_12]:radio:checked").val()+$("input[name=o_13]:radio:checked").val()+$("input[name=o_14]:radio:checked").val() ;
             var n = sumE.search('0000')
            
            
            
            if(n==-1 && sumE.length==4){
                $( "input[name=o_15]:radio" ).removeAttr('checked');
                $('#dis').show();   $('#dis1').show();
                document.getElementById('m_o_14').innerHTML ="";
                document.getElementById('m_o_15').innerHTML = '<img src="alert.gif"  height="18" width="18" alt="Se espera comentario"> Campo obligatorio';
                         
            }
            if(n==0 && sumE.length==4){
                $('#dis').hide(); $('#dis1').hide();
                $('#c_o_15').val('');
                document.getElementById('m_o_14').innerHTML ="";
                 document.getElementById('m_o_15').innerHTML ="";
                myVal[14] = true;
            }
            
            if(sumE.length>4) document.getElementById('m_o_14').innerHTML = '<img src="alert.gif"  height="18" width="18" alt="Se espera comentario"> Campos obligatorios';
           

        }

        if (ind == 15)
        {
               vComentario(ind, true);

        }
        
        if (ind == 16)
        {
                 if($("input[name=o_16]:radio:checked").val()==1)  {
                      myVal[ind - 1] = false;
                      vComentario(ind, true);
                 }else{
                       myVal[ind - 1] = true;
                       vComentario(ind, false);
                 }


        }




    });

    vComentario(18,false);
}


function val2() {

    vComenOnBlur();
    $("input:radio").click(function() {
        objthis = $(this);
        oname = objthis.attr("name");
        i_ = oname.indexOf('_');
        ind = oname.substring(i_ + 1, oname.length);
       if (ind < 14) {

            vCalificacion(objthis, ind);

        }

        



    });

    vComentario(14,false);
}
function vComenOnBlur() {
    $('input:text, textarea').blur(function() {

        objthis = $(this);
        oname = objthis.attr("name");
        i_ = oname.lastIndexOf('_');
        ind = oname.substring(i_ + 1, oname.length);
        str1 = 'o_'.concat(ind);
        r_val = $("input[name=" + str1 + "]:radio:checked").val();

        if (r_val < 10 && r_val > 2)
            vComentario(ind, true);
        else
            vComentario(ind, false);

    });


}

function  vComentario(ind, obl) {
    
   
    str = 'c_o_'.concat(ind);
    mstr = 'm_o_'.concat(ind);
 
    tcomen = document.getElementById(str).value;
   
    if (obl) {
  
         if (tcomen.length == 0) {
            
             
            document.getElementById(mstr).innerHTML = '<img src="alert.gif"  height="18" width="18" alt="Se espera comentario"> Comenta la causa de tu calificaci&oacute;n.'
            
            myVal[ind - 1] = false;
           
         }else if(tcomen.length < 10) {
             
            document.getElementById(mstr).innerHTML = '<img src="alert.gif"  height="18" width="18" alt="Se espera comentario"> M&iacute;nimo 10 caracteres.'
            myVal[ind - 1] = false;
        }else{
          document.getElementById(mstr).innerHTML = '';
            myVal[ind - 1] = true;
        }
        
       
    }


   else if (tcomen.length < 10 && tcomen.length != 0) {
        document.getElementById(mstr).innerHTML = '<img src="alert.gif"  height="18" width="18" alt="Se espera comentario"> M&iacute;nimo 10 caracteres.'
        myVal[ind - 1] = false;
    } else {
        document.getElementById(mstr).innerHTML = '';
        myVal[ind - 1] = true;
    }

}

function  vCalificacion(objthis, ind) {

    if (objthis.attr("value") < 10) {
        myVal[ind - 1] = false; 
        vComentario(ind, true);
        
    } else {
        vComentario(ind, false);
    }




}

function sendBuzon(form){
     
     comen = $('#comen').val();
     if(comen == '' || comen.length <10 ){
          alert('No hay texto, o muy pocos caracteres');
     }else{     
     sendForm(form, 'control/buzon/addBuzon.jsp' , 'contenido'); 
     alert('Mensaje enviado exitosamente');
    }

}


//validacion formularios de profesores
 var v_onlyCaracters = /^[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1]+(\s[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1]+)*[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1 ]$/;
 var v_nombre= /^[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1]+(\s[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1]+){0,2}[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1]$/;
 var v_onlyCaractersSB = /^[a-zA-Z \u00e1 \u00e9 \u00ed \u00f3 \u00fa \u00c1 \u00c9 \u00cd \u00d3  \u00da \u00f1 \u00d1]*$/; //sin espacio en blanco
 var v_rfc = /^[A-Z]{4}[0-9]{6}$/;
 var v_titulo= /^[A-Z]{4}[0-9]{6}$/;
 var v_email=/^\w+@[a-zA-Z_]+(\.[a-z]{2,3})*$/;
 var v_cuenta=/^[0-9]{9}$/;
 
 function addProfesor(form){
         
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var rfc = form.elements['rfc'].value;
     if( rfc.localeCompare("") != 0 && v_rfc.test(rfc) ){
       cadena =  cadena.concat('rfc=',rfc);
     }else{
         msj_error = msj_error.concat("RFC no valido, recuerda es sin homoclave")
        valido = false; 
    }
    
    var titulo = form.elements['titulo'].value;
     if( titulo.localeCompare("") != 0  ){
       cadena =  cadena.concat('&titulo=',titulo);
     }else{
         msj_error = msj_error.concat("<br>Selecciona un titulo") 
         valido = false; 
    }
    
     var nombre = form.elements['nombre'].value;
     if( nombre.localeCompare("") != 0 && v_nombre.test(nombre) ){
        cadena =  cadena.concat('&nombre=',nombre);
     }else{
         msj_error = msj_error.concat("<br>Nombre no valido")
         valido = false; 
    }
    
     var apeP = form.elements['apeP'].value;
     if( apeP.localeCompare("") != 0 && v_nombre.test(apeP) ){
        cadena =  cadena.concat('&apeP=',apeP);
     }else{
         msj_error = msj_error.concat("<br>Apellido paterno no valido")
         valido = false; 
    }
    
         var apeM = form.elements['apeM'].value;
     if( apeM.localeCompare("") != 0 && v_nombre.test(apeM) ){
        cadena =  cadena.concat('&apeM=',apeM);
     }else{
         msj_error = msj_error.concat("<br>Apellido materno no valido")
         valido = false; 
    }
    cadena =  cadena.concat('&hab=',form.elements['hab'].value);
    
    //alert(cadena);
     
     
     if(valido)  {
         sendCadena(cadena,'control/profesor/nuevo.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/profesores/catProfesores.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
     
     
     

     
 }
 
 function updateProfesor(){
     
           
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var rfc =$('#p_ref > span').text().trim();
    
    if( rfc.localeCompare("") != 0 && v_rfc.test(rfc) ){
       cadena =  cadena.concat('rfc=',rfc);
    }else{
         msj_error = msj_error.concat("RFC no valido, el formato corecto es: AAAA000000");
         valido = false; 
    }
    
    
    var titulo =$('#p_titulo > span').text().trim();
   
     if( titulo.localeCompare("") != 0  ){
       cadena =  cadena.concat('&titulo=',titulo);
     }else{
         msj_error = msj_error.concat("<br>Selecciona un titulo") 
         valido = false; 
    }
    var nombre =$('#p_nom > span').text().trim();
     
     if( nombre.localeCompare("") != 0 && v_nombre.test(nombre) ){
        cadena =  cadena.concat('&nombre=',nombre);
     }else{
         msj_error = msj_error.concat("<br>Nombre no valido")
         valido = false; 
    }
    
     var apeP = $('#p_apep > span').text().trim();
     if( apeP.localeCompare("") != 0 && v_nombre.test(apeP) ){
        cadena =  cadena.concat('&apeP=',apeP);
     }else{
         msj_error = msj_error.concat("<br>Apellido paterno no valido")
         valido = false; 
    }
    
         var apeM = $('#p_apem > span').text().trim();
     if( apeM.localeCompare("") != 0 && v_nombre.test(apeM) ){
        cadena =  cadena.concat('&apeM=',apeM);
     }else{
         msj_error = msj_error.concat("<br>Apellido materno no valido")
         valido = false; 
    }
    cadena =  cadena.concat("&hab=",$("#cb_edit_hab").val());
    
    
         var email = $('#p_email > span').text().trim();
     if( email.localeCompare("") != 0 && v_email.test(email) ){
        cadena =  cadena.concat('&email=',email);
     }else{
         msj_error = msj_error.concat("<br>Email no valido")
         valido = false; 
    }
    cadena =  cadena.concat("&hab=",$("#cb_edit_hab").val());
    
    
    //alert(cadena);
     
     if(!aux_edit) {
         msj_error = msj_error.concat("<br>Verificar que todos los campos esten cerrados");
         valido = false; 
         
     }
     if(valido)  {
         sendCadena(cadena,'control/profesor/editar.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/profesores/catProfesores.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
     
 }
 
function updateHorario(){
     
           
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var descr =$('#p_des > span').text().trim();
    
    if( descr.localeCompare("") != 0 && v_onlyCaractersSB.test(descr) ){
       cadena =  cadena.concat('pDes=',descr);
    }else{
         msj_error = msj_error.concat("Verificar descripci\u00f3n");
         valido = false; 
    }
    
    var horario =$('#p_id > span').text().trim();
    cadena =  cadena.concat('&horario=',horario);
    
    //alert(cadena);
     
     if(!aux_edit) {
         msj_error = msj_error.concat("<br>Verificar que todos los campos esten cerrados");
         valido = false; 
     }else{ valido = true}
     
     
     if(valido)  {
         sendCadena(cadena,'control/horarios/editar.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/horarios/catHorarios.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
     
 }
 
 function addHorario(form){
         
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var desc = form.elements['desc'].value;
     if( desc.localeCompare("") != 0 && v_onlyCaractersSB.test(desc) ){
       cadena =  cadena.concat('desc=',desc);
     }else{
         msj_error = msj_error.concat("Verifica la descripci\u00f3n")
        valido = false; 
    }
    
     
     if(valido)  {
         sendCadena(cadena,'control/horarios/nuevo.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/horarios/catHorarios.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
 }
     
     function frm_eliminarProfesor(profe){
    
    
    pasarParamertros('control/profesor/eliminar.jsp','rfc='+profe);
    cerrarAux();
    
    setTimeout(function (){ 
    contenido('contenido','catalogos/profesores/catProfesores.jsp');
    },400);
}


function frm_eliminarHorario(hr){
    
    
    pasarParamertros('control/horarios/eliminar.jsp','hr='+hr);
    cerrarAux();
    
    setTimeout(function (){ 
    contenido('contenido','catalogos/horarios/catHorarios.jsp');
    },400);
}


     
 
 
function frm_eliminarPractica(hr){
    
    
    pasarParamertros('control/practicas/eliminar.jsp','practica='+hr);
    cerrarAux();
    
    setTimeout(function (){ 
    contenido('contenido','catalogos/horarios/catHorarios.jsp');
    },400);
}



 
 function addPractica(form){
         
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var desc = form.elements['desc'].value;
     if( desc.localeCompare("") != 0 && v_onlyCaractersSB.test(desc) ){
       cadena =  cadena.concat('desc=',desc);
     }else{
         msj_error = msj_error.concat("Verifica la descripci\u00f3n")
        valido = false; 
    }
    
     
     if(valido)  {
         sendCadena(cadena,'control/horarios/nuevo.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/horarios/catHorarios.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
 }
     
     
     
     

     function updatePractica(){
     
           
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var descr =$('#p_des > span').text().trim();
    
    if( descr.localeCompare("") != 0 && v_onlyCaractersSB.test(descr) ){
       cadena =  cadena.concat('desc=',descr);
    }else{
         msj_error = msj_error.concat("Verificar descripci\u00f3n");
         valido = false; 
    }
    
    
       var descr =$('#cb_p_tipo').val().trim();
    
    if( descr.localeCompare("") != 0 && v_onlyCaractersSB.test(descr) ){
       cadena =  cadena.concat('desc=',descr);
    }else{
         msj_error = msj_error.concat("Verificar descripci\u00f3n");
         valido = false; 
    }
    
    var idp =$('#p_id > span').text().trim();
    cadena =  cadena.concat('&practica=',idp);
    
    //alert(cadena);
     
     if(!aux_edit) {
         msj_error = msj_error.concat("<br>Verificar que todos los campos esten cerrados");
         valido = false; 
     }else{ valido = true}
     
     
     if(valido)  {
         sendCadena(cadena,'control/horarios/editar.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/horarios/catHorarios.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
     
 }
 
 function addAlumno(form,grupo){
         
    var cadena="";
    msj_error = ""; 
    valido = true;
    
     
     var cuenta = form.elements['cuenta'].value;
     if( rfc.localeCompare("") != 0 && v_cuenta.test(cuenta) ){
       cadena =  cadena.concat('cuenta=',cuenta);
     }else{
         msj_error = msj_error.concat("Número de cuenta no valido")
        valido = false; 
    }
    
    
    
     var nombre = form.elements['nombre'].value;
     if( nombre.localeCompare("") != 0 && v_nombre.test(nombre) ){
        cadena =  cadena.concat('&nombre=',nombre);
     }else{
         msj_error = msj_error.concat("<br>Nombre no valido")
         valido = false; 
    }
    
     var apeP = form.elements['apeP'].value;
     if( apeP.localeCompare("") != 0 && v_nombre.test(apeP) ){
        cadena =  cadena.concat('&apeP=',apeP);
     }else{
         msj_error = msj_error.concat("<br>Apellido paterno no valido")
         valido = false; 
    }
    
         var apeM = form.elements['apeM'].value;
     if( apeM.localeCompare("") != 0 && v_nombre.test(apeM) ){
        cadena =  cadena.concat('&apeM=',apeM);
     }else{
         msj_error = msj_error.concat("<br>Apellido materno no valido")
         valido = false; 
    }
    
    
    
      var grupo = form.elements['grupo'].value;
   /*  if( apeM.localeCompare("") != 0 && v_nombre.test(apeM) ){
        cadena =  cadena.concat('&apeM=',apeM);
     }else{
         msj_error = msj_error.concat("<br>Apellido materno no valido")
         valido = false; 
    }*/
    cadena =  cadena.concat('&grupo=',form.elements['grupo'].value);
    
    
    
    //alert(cadena);
     
     
     if(valido)  {
         sendCadena(cadena,'control/profesor/nuevo.jsp','con_div_emergente');
         
         $('#emergente_err_mens').html("");
         $("#emergente_err_mens").hide();
        
         $('#div_emergente').hide();setTimeout(function() {
          contenido('contenido','catalogos/profesores/catProfesores.jsp');
         },500);
       
     
     }
     else {
         $("#emergente_err_mens").html(msj_error);
         $("#emergente_err_mens").show();
     }
     
     
     

     
 }