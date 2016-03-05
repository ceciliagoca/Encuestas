/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;
  import java.io.FileNotFoundException;
import java.io.IOException;
import com.csvreader.CsvReader;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.xml.crypto.Data;

/**
 *
 * @author Cecilia
 */
public class CSV2BD {
  


String ruta;

    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public CSV2BD() {
      // ruta = "C:/Users/Cecilia/Documents/encuestas/";
       //ruta = "C:/Users/DIMEI/Desktop/formatos/";
         ruta = "/home/cecilia/";
         //ruta = "/home/cecilia/Documents/sis/alumnos/";
        // ruta = "/home/cecilia/Desktop/DIMEI/documentacion/";
        //  ruta = "/home/cecilia/Documents/sis/prueba/";
        
    }




public void cargarAlumnos(String ruta_) throws FileNotFoundException, SQLException {


//Le pasamos la URL del archivo CSV a leer.
CsvReader reader = new CsvReader(ruta_);

Conexion c = new Conexion();
Connection  con = c.getConexion();
try {
    String name="";
while (reader.readRecord())
{
     System.out.println(reader.get(0));
     String[] x= reader.get(1).split(" ");
     name= x[2];
     
 
     for(int i = 3 ; i<x.length; i++ )
       if(i<5) name = name + " " + x[i];
   
   
      String grupo= reader.get(2);
   
   
//reader.get(Integer) - devuelve el contenido del numero de columna que le pasamos.
          PreparedStatement pstmt;
           //id //nombre //apep // apem grupo
            pstmt = con.prepareStatement("select addAlumno(?,?,?,?,?)");
            
            pstmt.setString(1, reader.get(0)); //cuenta
            pstmt.setString(2, name); //no
            pstmt.setString(3, x[0]); //pa
            pstmt.setString(4, x[1]); //mat
           
            
              System.out.println(x[0] + x[1] + name +grupo);
           
          /*  PreparedStatement pgetGrupo;
            pgetGrupo = con.prepareStatement("select getGrupo(?)");
            pgetGrupo.setString(1,reader.get(6));
            ResultSet rsGrupo = pgetGrupo.executeQuery();
            rsGrupo.next();
            */
            //pstmt.setInt(5,rsGrupo.getInt(1)); //grupo
            //rsGrupo.close();
            //pgetGrupo.close();
            
            
            pstmt.setInt( 5, Integer.parseInt(grupo));
            
            ResultSet rs = pstmt.executeQuery();
            rs.close();
            
            pstmt.close();
    
  

}
} catch (IOException e) {
e.printStackTrace();
}
con.close();


reader.close();

}
public void repararAlumnos() throws FileNotFoundException, SQLException {

 
   CsvReader reader = new CsvReader("/home/cecilia/Desktop/alumnos.txt");
   // CsvReader reader = new CsvReader("C:\\Users\\DIMEI\\Desktop\\alumnos.txt");

Conexion c = new Conexion();
Connection  con = c.getConexion();
try {
                String name="";
            while (reader.readRecord())
            {
                 String cuenta = reader.get(1);

                   String[] x= reader.get(2).split(" ");
                   name= x[2];
                   for(int i = 3 ; i<x.length; i++ )
                     name = name + " " + x[i];


                 System.out.println(cuenta +" "  + name);

                   Statement pstmt = con.createStatement();

                         pstmt.execute("update alumno set nombre = '"  + name +"' where id='" + cuenta+ "'" );
                        pstmt.close();

            }


} catch (IOException e) {
e.printStackTrace();
}
con.close();


reader.close();


}

public void repararComentarios() throws FileNotFoundException, SQLException, IOException {

 //File file = new File("C:\\Users\\DIMEI\\Desktop\\comentarios.txt");
    File file = new File("/home/cecilia/Desktop/comentarios.txt");

    BufferedReader bufRdr  = new BufferedReader(  new InputStreamReader(new FileInputStream(file),"ISO-8859-1"));
    String line = " ";
    
Conexion c = new Conexion();
Connection  con = c.getConexion();

                                   
		 line = bufRdr.readLine();
                  line = bufRdr.readLine();
                  //201
                   String query =   "update comentarios set comentario = ? where idencuesta= ? and idpregunta= ? " ;
                                   
                   PreparedStatement pstmt = con.prepareStatement(query);
			while (line != null)  {
                               
                                
                            
                                    String[] x= line.split(" , ");
                            
                                    pstmt.setString(1, x[2]);
                                    pstmt.setInt(2, Integer.parseInt(x[0]));
                                    pstmt.setInt(3, Integer.parseInt(x[1]));
                            
                                    pstmt.execute();
                                    
                                    System.out.println(query);
                                    line = bufRdr.readLine();
                        
                                    
                        }
                       
 pstmt.close();
                                     

}

public void repararBuzon()  throws FileNotFoundException, SQLException, IOException {

 
    File file = new File("/home/cecilia/Desktop/buzon.txt");

    BufferedReader bufRdr  = new BufferedReader(  new InputStreamReader(new FileInputStream(file),"ISO-8859-1"));
    String line = " ";
    
Conexion c = new Conexion();
Connection  con = c.getConexion();

                                    
		 line = bufRdr.readLine();
                  line = bufRdr.readLine();
                 
                  PreparedStatement pstmt1 = con.prepareStatement("update buzon set comen = ? where idbuzon= ? and usuario=?");
                  PreparedStatement pstmt2 = con.prepareStatement("update buzon set respuesta = ? where idbuzon= ? and usuario=?");
			while (line != null)  {
                               
                                
                                    String[] x= line.split(" %% ");
                                    
                                    pstmt1.setString(1, x[2]);
                                    pstmt1.setInt(2, Integer.parseInt(x[0]));
                                    pstmt1.setString(3, x[1]);
                                    
                                    pstmt2.setString(1, x[5]);
                                    pstmt2.setInt(2, Integer.parseInt(x[0]));
                                    pstmt2.setString(3, x[1]);
                                    
                                    pstmt1.execute();
                                    pstmt2.execute();
                                    line = bufRdr.readLine();
                        
                                    
                        }
                       pstmt1.close();
                        pstmt2.close();

}

public void repararPracticas()  throws FileNotFoundException, SQLException, IOException {

 
    File file = new File("/home/cecilia/Desktop/practicas.txt");

    BufferedReader bufRdr  = new BufferedReader(  new InputStreamReader(new FileInputStream(file),"ISO-8859-1"));
    String line = " ";
    
Conexion c = new Conexion();
Connection  con = c.getConexion();

                                  
		 line = bufRdr.readLine();
                  line = bufRdr.readLine();
                  
                   PreparedStatement pstmt = con.prepareStatement("update practicas set nombre = ? where idpractica= ? ");
                                 
			while (line != null)  {
                               
                                    String[] x= line.split(",");
                                   
                                    pstmt.setString(1, x[1]);
                                    pstmt.setInt(2, Integer.parseInt(x[0]));
                                  pstmt.execute();
                                  
                                    line = bufRdr.readLine();
                        
                                    
                        }
                       
 pstmt.close();

}


public void cargarCalendarizacion(String semestre) throws FileNotFoundException, SQLException {

//Le pasamos la URL del archivo CSV a leer.
//CsvReader reader = new CsvReader("~/Documents/Encuestas/Alumnos/calendario.txt");
    
    
    
    
    Conexion c = new Conexion();
    Connection  con = c.getConexion();
    int cal1,cal2;
    //una por horario...
     PreparedStatement pstmt;
     pstmt = con.prepareStatement("SELECT addCal(?,?)");
     pstmt.setInt(1,1);
     pstmt.setString(2,semestre);
     ResultSet rs = pstmt.executeQuery();
     rs.next();
     cal1=rs.getInt(1);
     rs.close();
     pstmt.close();
     
     pstmt = con.prepareStatement("SELECT addCal(?,?)");
     pstmt.setInt(1,2);
     pstmt.setString(2,semestre);
     rs = pstmt.executeQuery();
     rs.next();
     cal2=rs.getInt(1);
     rs.close();
     pstmt.close();
     
   
    CsvReader reader = new CsvReader(ruta+"calendario.txt");
    
    //System.out.println("cal1 " + cal1 + " cal2 " + cal2 );
try {
    int i=0;
  while( reader.readRecord()){

        String b1 = reader.get(1);
        String b2 = reader.get(2);

        String a1 = reader.get(4);
        String a2 = reader.get(5);
   System.out.println((i+1)+ " mar y jue " + b1 + " "+b2+"\n lmv" +a1 +" " +a2);
    
   
     pstmt = con.prepareStatement("SELECT addCalXPractica(?,?,?,?)");
     pstmt.setInt(1,cal1);
     pstmt.setInt(2,i+1);
     pstmt.setString(3, a1);
     pstmt.setString(4, a2);
     
      pstmt.executeQuery();
    
     pstmt.close();
     pstmt = con.prepareStatement("SELECT addCalXPractica(?,?,?,?)");
     pstmt.setInt(1,cal2);
     pstmt.setInt(2,i+1);
     pstmt.setString(3, b1);
     pstmt.setString(4, b2);
     
     pstmt.executeQuery();
    i++;
     
}
} catch (IOException e) {
e.printStackTrace();
}

reader.close();

}


public void cargarGrupos(String archivo) throws FileNotFoundException {

//Le pasamos la URL del archivo CSV a leer.
CsvReader reader = new CsvReader(archivo);
try {
while (reader.readRecord())
{
    //reader.get(Integer) - devuelve el contenido del numero de columna que le pasamos.
    String id = reader.get(0);
    String producto = reader.get(1);
    String stock = reader.get(2);
    String precio = reader.get(3);
    System.out.println("Filas: " + id + "-" + producto +
    "-" + stock + "-" + precio);
}
} catch (IOException e) {
e.printStackTrace();
}

reader.close();

}
}

