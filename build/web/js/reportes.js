/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


  function graficar(s1,ticks,graf){
       
       
         plot2 = $.jqplot(graf, [s1], {
    
            seriesDefaults: {
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true },
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks
                }
            }
        });
        
         $('#'+graf).bind('jqplotDataHighlight', 
            function (ev, seriesIndex, pointIndex, data) {
                $('#info2').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
            }
        );
            
        $('#'+graf).bind('jqplotDataUnhighlight', 
            function (ev) {
                $('#info2').html('Nothing');
            }
        );
    
       
    }
    
    function reporte1(semestre){ //de practricas por semestre
           
       contenidoP("seccGrafica","consultas/reportes/promediosPracticas.jsp","1&sem="+semestre);
    }