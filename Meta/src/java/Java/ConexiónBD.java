package Java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Properties;

public class ConexiónBD {
    protected static Connection getConnection(){
        String url;
        url="jdbc:mysql://localhost/plataforma";
        
        Connection con = null;
        Properties connectionProperties = new Properties();
        connectionProperties.put("user", "root");
        //connectionProperties.put("password", "n0m3l0");
        connectionProperties.put("password", "Acc3_JM2018a");
        connectionProperties.put("charSet", "ISO-8859-1");
        
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            //connectionProperties="useUnicode=yes;characterEncoding=ISO-8859-1";
            con = DriverManager.getConnection(url,connectionProperties);
            System.out.println("Conexión con la base de datos establecida correctamente");
          
        }catch(ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException e){
            System.out.println("Error al conectarse con la base de datos");
            System.out.println(e.getMessage());
            System.out.println(Arrays.toString(e.getStackTrace()));
        }
       return con;
    }
}
