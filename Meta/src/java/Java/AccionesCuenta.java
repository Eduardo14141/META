package Java;

import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Tutor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AccionesCuenta {
    public static int Guardar(Cuenta e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="insert into cuenta (Nombre, appat, apmat, sexo, email, Contraseña, titulo, tCuenta) "
                        + "values(?,?,?,?,?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, e.getNombre());
                ps.setString(2, e.getAppat());
                ps.setString(3, e.getApmat());
                ps.setInt(4, e.getSexo());
                ps.setString(5, e.getEmail());
                ps.setString(6, e.getPassword());
                ps.setInt(7, e.getTítulo());
                ps.setInt(8, e.getTipoCuenta());
                status=ps.executeUpdate();
                
                int num= ComprobarCreacionCuenta(e.getEmail());
                if(num<1) return 0;
                else{
                    switch (e.getTipoCuenta()) {
                        case 1:
                            String NL="insert into alumno (idCuenta, xp) values(?,?)";
                            PreparedStatement s = con.prepareStatement(NL);
                            s.setInt(1, num);
                            s.setInt(2, 0);
                            status=s.executeUpdate();
                            break;
                        case 2:
                            String codigo="";
                            List <Tutor> lista = AccionesCuenta.getAllCodigos();
                            while(codigo.length()<5){
                                codigo= creaPass();
                                if(codigo.length()<1){
                                    codigo="a";
                                }
                                for (Tutor d: lista) {
                                    if(d.getCódigo().equalsIgnoreCase(codigo)){
                                        codigo="a";
                                    }
                                }
                            }
                            String NN="insert into tutor (idCuenta, codigo) values(?,?)";
                            PreparedStatement p = con.prepareStatement(NN);
                            p.setInt(1, num);
                            p.setString(2,codigo);
                            status=p.executeUpdate();
                            break;
                        default:
                            EliminarCuenta(num);
                            break;
                    }
                }
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al registrar al usuario");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static List<Cuenta> getEmails(){
        List<Cuenta> lista= new ArrayList<Cuenta>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="select email from Cuenta";
                PreparedStatement ps = con.prepareStatement(Q);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Cuenta e= new Cuenta();
                    e.setEmail(rs.getString(1));
                    
                    lista.add(e);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener Emails");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static List<Tutor> getAllCodigos(){
        List<Tutor> lista= new ArrayList<Tutor>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="select codigo from tutor";
                PreparedStatement ps = con.prepareStatement(Q);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Tutor e= new Tutor();
                    e.setCódigo(rs.getString(1));
                    lista.add(e);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener Códigos");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static String creaPass(){
        char[] elementos={'1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        String pass="";
        while(pass.length()<8){
            int el = (int)(Math.random()*35);
            pass += elementos[el];
        }
        return pass;
    }
    public static int ComprobarCreacionCuenta (String correo){
        int e=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String q = "SELECT idCuenta FROM cuenta where email=?";
                PreparedStatement ps = con.prepareStatement(q);
                ps.setString(1, correo);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) e=rs.getInt(1);
            }
        }catch(SQLException d){
            System.out.println("Error al comprobar cuenta");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static int EliminarCuenta (int idCuenta){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "Delete FROM cuenta where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idCuenta);
                status = ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Error al comprobar cuenta");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return status;
    }
    public static Cuenta IniciarS (String correo, String pass){
        Cuenta e = new Cuenta();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM Cuenta where email=? and contraseña=?";
                PreparedStatement ps = con.prepareStatement(Q);
                
                ps.setString(1, correo);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdCuenta(rs.getInt(1));
                    e.setNombre(rs.getString(2));
                    e.setAppat(rs.getString(3));
                    e.setApmat(rs.getString(4));
                    e.setSexo(rs.getInt(5));
                    e.setEmail(rs.getString(6));
                    e.setPassword(rs.getString(7));
                    e.setTítulo(rs.getInt(8));
                    e.setTipoCuenta(rs.getInt(9));
                }
                if(e.getIdCuenta()==0) e=null;
            }
        }catch(SQLException d){
            System.out.println("Error al iniciar sesión");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static Estudiante ObtenerEstudianteByIdCuenta (int idCuenta){
        Estudiante e = new Estudiante();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM alumno where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(Q);
                
                ps.setInt(1, idCuenta);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdEstudiante(rs.getInt(1));
                    e.setIdCuenta(rs.getInt(2));
                    e.setXp(rs.getInt(3));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener estudiante por idCuenta");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static int ActualizarDatos(Cuenta e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="update cuenta set nombre=?, appat=?, apmat=?, email=?, titulo=? where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, e.getNombre());
                ps.setString(2, e.getAppat());
                ps.setString(3, e.getApmat());
                ps.setString(4, e.getEmail());
                ps.setInt(5, e.getTítulo());
                ps.setInt(6, e.getIdCuenta());                
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al actualizar los datos");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int ActualizarPassword(int idCuenta, String password){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="update Cuenta set contraseña=? "
                        + "where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, password);
                ps.setInt(2, idCuenta);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al actualizar la contraseña");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static Cuenta ObtenerCuentaByTutor (int idTutor){ //checar si se utiliza
        Cuenta e = new Cuenta();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                Tutor tut= ObtenerTutorByIdTutor(idTutor);
                String q = "SELECT * FROM cuenta where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(q);
                ps.setInt(1, tut.getIdCuenta());                
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdCuenta(rs.getInt(1));
                    e.setNombre(rs.getString(2));
                    e.setAppat(rs.getString(3));
                    e.setApmat(rs.getString(4));
                    e.setSexo(rs.getInt(5));
                    e.setEmail(rs.getString(6));
                    e.setPassword(rs.getString(7));
                    e.setTítulo(rs.getInt(8));
                    e.setTipoCuenta(rs.getInt(9));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener cuenta por tutor");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static boolean isNumeric(String str){
        try{
            int d = Integer.parseInt(str);
        }
        catch(NumberFormatException nfe){
            return false;
        }
        return true;
    }
    public static Tutor ObtenerTutorByIdCuenta (int idCuenta){
        Tutor e = new Tutor();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM tutor where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(Q);                
                ps.setInt(1, idCuenta);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdTutor(rs.getInt(1));
                    e.setIdCuenta(rs.getInt(2));
                    e.setCódigo(rs.getString(3));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener Tutor activo");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static Cuenta ObtenerCuentaByEstudiante (int idEstudiante){ //checar si se usa
        Cuenta e = new Cuenta();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                //Obteniendo idCuenta
                Estudiante est = ObtenerEstudianteByIdEstudiante(idEstudiante);
                //Obteniendo cuenta
                String q = "SELECT * FROM cuenta where idCuenta=?";
                PreparedStatement ps = con.prepareStatement(q);
                ps.setInt(1, est.getIdCuenta());                
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdCuenta(rs.getInt(1));
                    e.setNombre(rs.getString(2));
                    e.setAppat(rs.getString(3));
                    e.setApmat(rs.getString(4));
                    e.setSexo(rs.getInt(5));
                    e.setEmail(rs.getString(6));
                    e.setPassword(rs.getString(7));
                    e.setTítulo(rs.getInt(8));
                    e.setTipoCuenta(rs.getInt(9));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener cuenta por tutor");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static Estudiante ObtenerEstudianteByIdEstudiante (int idEstudiante){ //checar si se usa
        Estudiante e = new Estudiante();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM alumno where idAlumno=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idEstudiante);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdEstudiante(rs.getInt(1));
                    e.setIdCuenta(rs.getInt(2));
                    e.setXp(rs.getInt(3));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener estudiante por idCuenta");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static Tutor ObtenerTutorByIdTutor (int idTutor){ //checar si se utiliza
        Tutor e = new Tutor();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM tutor where idTutor=?";
                PreparedStatement ps = con.prepareStatement(Q);                
                ps.setInt(1, idTutor);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdTutor(rs.getInt(1));
                    e.setIdCuenta(rs.getInt(2));
                    e.setCódigo(rs.getString(3));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener Tutor activo");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
}