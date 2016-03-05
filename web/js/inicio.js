


$(document).ready(function() {
    showInicio();
   
    $("#div_salir").css('cursor','pointer');

	




});
function updateTips( t ) {
    tips.text( t ).addClass( "ui-state-highlight" );
    setTimeout(function() {
    tips.removeClass( "ui-state-highlight", 1500 );}, 500 );
}
function showInicio(){
     var name = $("#name"), password = $("#password");
     allFields = $([]).add(name).add(password);
     tips = $( ".validateTips" );
    
   $("#div_acceso").dialog({
        dialogClass: "no-close",
        autoOpen: false,
        height: 300,
        width: 365,
        modal: true,
        resizable: false,
        draggable: false,
        
        buttons: {
            
            "Recuperar contrase\u00f1a":function (){
                            $(function() {
                                $( "#contraDiv" ).dialog({
                                resizable: false,
                                height:140,
                                modal: true,
                                buttons: {
                                    "Aceptar": function() {
                                        pasarParamertros("control/usuarios/addUsuario.jsp",'&cuenta='+name.val()+'&bandera=3');
                                       setTimeout(function(){
                                     
                                            updateTips(ajax_res); 
                                 
                                         $('#contraDiv').dialog( "close" );
                    }

                                   ,1000);

                                           
                                           
                                    },
                                    "Cancelar": function() {
                                            $( this ).dialog( "close" );
                                    }
                                }
                                });
                            });
                    } ,
                    
            "Crear usuario": function() {
                $(this).dialog("close");
               tips.text("").removeClass( "ui-state-highlight", 0);
                
               
    
                showAddUser();

            },
            
                    
                    "Ingresar": function() {
                //confirmar usuario y dar acceso
                
                if(name.val().length===0 || password.val().length===0 ){
                updateTips( "Datos invalidos");
		}else {
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
                            sendCadena("tipo="+x,"contenido.jsp","contenido");
                            sendCadena("tipo="+x,"menu.jsp","c_menu");
                            setTimeout(function() { 
                                menu();
                                $('#principal').show('slow');
                            },400);
                            

                        } else {
                          updateTips( "Datos invalidos");
                        }

                    }, 1500 );

                }
       
            }
        }
       
    });
    
    
    $("#div_acceso").dialog("open");

}

function showAddUser(){
    tips = $( ".validateTips" );
    
    var cuenta = $("#cuenta"), brigada = $("#brigada"), emailAlumno = $("#emailAlumno"),passwAlumno = $("#passwAlumno"), passwAlumno1 = $("#passwAlumno1") ;
    
  
  cuenta.text("");
  brigada.text("");
   emailAlumno.text("");
   passwAlumno.text("");
   passwAlumno1.text("");
    $("#div_addUser").dialog({
        dialogClass: "no-close", 
        autoOpen: false,
        height: 300,
        width: 365,
        modal: true,
        resizable: false,
        draggable: false,
        buttons: {
            "Aceptar": function() {
             
                val = $( ":radio[name='sel']:checked" ).val();
            
                if(val==0){
                    
                   // if(!numeroValido){updateTips( "N\u00famero de cuenta no valido" ); ban = false }
                    if(cuenta.val().length== 0 || brigada.val().length== 0 || emailAlumno.val().length== 0 || passwAlumno.val().length== 0  || passwAlumno1.val().length== 0 ){updateTips( "Todos los campos deben estar llenos" ); ban = false; }else{ban=true}
                    //if(passwAlumno.val() != passwAlumno1.val()){updateTips( "Las contrase\u00f1as deben de coincidir" ); ban = false; }
                    br = (!(/^([0-9])*$/.test(brigada.val())))?   "0" : brigada.val();
                   // if(!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(emailAlumno.val()))) {updateTips( "Email invalido" ); ban = false; }
                 // alert(ban);
                  
                 if(ban){
                
                      pasarParamertros("control/usuarios/addUsuario.jsp",'&cuenta='+cuenta.val()+'&bandera=1&brigada='+br+'&passwd='+passwAlumno1.val()+'&passwd1='+passwAlumno.val()+'&mail='+emailAlumno.val());
                      setTimeout(function(){
                            if((ajax_res.search('good')!=-1) ){ 
                              alert("Usuario creado exitosamente");
                                updateTips(""); 
                                $("#div_addUser").dialog("close");
                                 $("#div_acceso").dialog("open");
             
            } else{
                updateTips(ajax_res); 
                
            }
            }
    
        ,1000);
                 }  
                  // 
                  // 
// var cadena = getForm($("#frmAddUser"));
                //alert(cadena);
                  // 
                }else{
                   // alert('profesor')
                   
                   
                   var profesor = $("#profesor"), emailProfe = $("#emailProfe"), passwProfe = $("#passwProfe"), passwProfe1 = $("#passwProfe1") ;
                    if(profesor.val().length== 0 || emailProfe.val().length== 0 || passwProfe.val().length== 0 || passwProfe1.val().length== 0 ){updateTips( "Todos los campos deben estar llenos" ); ban = false; }else{ban=true}
                   
                    if(ban){
                
                      pasarParamertros("control/usuarios/addUsuario.jsp",'&profesor='+profesor.val()+'&bandera=2&passwd='+passwProfe1.val()+'&passwd1='+passwProfe.val()+'&mail='+emailProfe.val());
                      setTimeout(function(){
                            if((ajax_res.search('good')!=-1) ){ 
                              alert("Usuario creado exitosamente");
                                updateTips(""); 
                                $("#div_addUser").dialog("close");
                                 $("#div_acceso").dialog("open");
             
            } else{
                updateTips(ajax_res); 
                
            }
            }
    
        ,1000);
                 }  
                   
                   
                   
                }
                    
                    

            },
            Cancel: function() {
                $(this).dialog("close");
                $("#div_acceso").dialog("open");
            }
        }
        
    });
   
    $("#div_addUser").dialog("open");
    
}


  
function calendarioRange(from, to){
         from = "#".concat(from); 
         to= "#".concat(to); 
            
         $( from ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 4,
			onClose: function( selectedDate ) {
				$( to ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$( to ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 4,
			onClose: function( selectedDate ) {
				$( from ).datepicker( "option", "maxDate", selectedDate );
			}
		});

}


function calSemestre(from, to){
   
    
         from = "#".concat(from); 
         to= "#".concat(to); 
      
         x = $('#cfrom').prop('value').split("/");
      
          n = (parseInt(x[1])<6)?1:2;
          a = (n==1)?(parseInt(x[2])+1):x[2];
         
         $('#t_smestre_aux').html(a+'-'+n+'<div ondblclick="show_t_editable()" style="font-variant-caps: all-small-caps; color: darkred; font-size: small; "> Si el semestre no es correcto favor de corregirlo, con doble click<div>'); 
       
          
       
}


function calSemestre_(value){
   
    
         
         
         $('#t_smestre_aux').html(value); 
       
          
       
}

function show_t_editable(){
      $('#t_smestre_aux').html('<input name="t_editable" onblur(calSemestre_(this.value())); type="text" >')
    
}
function addGrupo(){
    //$('#tb_grupos').append('<tr><td><select> <option>1</option> <option>2</option> <option>3</option> <option>4</option></select></td>  <td><input name="profesor" type="hidden" > <select> <%                 pstmt = con.prepareStatement("select * from l_profesores");                ResultSet rs = pstmt.executeQuery(); while(rs.next()){ %> <option value="<%=rs.getString(6)%>"><%=rs.getString(1)+" "+ rs.getString(2) + " "+ rs.getString(3) + rs.getString(4)%></option> <%  }       rs.close();   pstmt.close();   %>   </select></td> <td><select> <%  pstmt = con.prepareStatement("select * from l_horarios");                rs = pstmt.executeQuery();    while(rs.next()){ %> <option value="<%=rs.getInt(1)%>"> <%=rs.getString(2)%></option>       <% } rs.close(); pstmt.close(); %> </select></td> </tr>')
    ;}


function guardarGrupos(i){
    valor="x";
    for(id=0; id<i; id++){
        
        valor = valor +"&grupo="+ $('#grupo_'+id).val() + "&profesor=" + $('#profesor_'+id).val() + "&cal=" + $('#cal_'+id).val() ;
        
    }
    
    alert (valor);
    
    contenidoP("profesores","control/calendario/cargarGrupos.jsp",valor);
    alert("grupos agregado exitosamens");
    $('#i_3').hide(); $('#i_4').show(); 
    
    
}
     
     
     function addSemestre_Paso2(form){
         
         var tabs = $( "#tabs" ).tabs();
	x= tabs.find( ".ui-tabs-nav" );
        y = x._findNextTab();
        
         
         
     }