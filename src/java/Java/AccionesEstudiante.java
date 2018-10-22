package Java;

import TablasSQL.Comentario;
import TablasSQL.Jefes;
import TablasSQL.Misiones;
import TablasSQL.Sesiones;
import TablasSQL.Tarea;
import TablasSQL.Tutor;
import TablasSQL.Vinculo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class AccionesEstudiante {
    public static String getFecha(){
        Date fecha= new Date();
        return fecha.getDate()+"-"+(fecha.getMonth()+1)+"-"+(fecha.getYear()+1900);
    }
    public static Sesiones ObtenerSesionHoy (int idAlumno){
        Sesiones e = new Sesiones();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM sesiones where idAlumno=? and fecha=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idAlumno);
                ps.setString(2, getFecha());
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdSesion(rs.getInt(1));
                    e.setNumero(rs.getInt(2));
                    e.setFecha(rs.getString(3));
                    e.setIdAlumno(rs.getInt(4));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener Comentario activo");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
            e=null;
        }        
        return e;
    }
    public static List<Tarea> getTareasDelEstudiante(int idEstudiante){
        List<Tarea> lista= new ArrayList<Tarea>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="select * from Tareas where idAlumno=? and Categoria!=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idEstudiante);
                ps.setInt(2, 0);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Tarea m= new Tarea();
                    m.setIdTarea(rs.getInt(1));
                    m.setFecha(rs.getString(2));
                    m.setCategoria(rs.getInt(3));
                    m.setDescripcion(rs.getString(4));
                    m.setIdAlumno(rs.getInt(5));
                    m.setProgreso(rs.getInt(6));
                    
                    lista.add(m);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener tareas");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static List<Comentario> getComentariosTarea(int idTarea){
        List<Comentario> lista= new ArrayList<Comentario>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="select * from comentarios where idTarea=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idTarea);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Comentario e = new Comentario();
                    e.setIdComentario(rs.getInt(1));
                    e.setComentario(rs.getString(2));
                    e.setIdTutor(rs.getInt(3));
                    e.setIdTarea(rs.getInt(4));
                    e.setActivo(rs.getInt(5));
                    lista.add(e);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener ComentariosTarea");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static Tarea ObtenerTareaActiva (int idTarea){
        Tarea e = new Tarea();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT descripcion, idAlumno, progreso FROM tareas where idTarea=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idTarea);                
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setDescripcion(rs.getString(1));
                    e.setIdAlumno(rs.getInt(2));
                    e.setProgreso(rs.getInt(3));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener estudiante activo");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static List<Comentario> getMisComentarios(int idAlumno){
        List<Comentario> lista= new ArrayList<Comentario>();
        List<Tarea> mi = getTareasDelEstudiante(idAlumno);
        mi.stream().map((miTarea) -> getComentariosTarea(miTarea.getIdTarea())).forEachOrdered((ia) -> {
            lista.addAll(ia);
        });
        return lista;
    }
    public static int DesactivarComentario(int idComentario){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update comentarios set CActivo=? where idComentario=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, 0);
                ps.setInt(2, idComentario);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al Desactivar el comentario");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int SubirTareas(Tarea e){
        int status=0;
        int idAlumno;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="insert into tareas (fecha, categoria, descripcion, idAlumno, progreso) values(?,?,?,?,?)";
                idAlumno= e.getIdAlumno();
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, getFecha());
                ps.setInt(2, 3);
                ps.setString(3, e.getDescripcion());
                ps.setInt(4, idAlumno);
                ps.setInt(5, 0);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al Subir Tarea");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int UltimaTareaAgregadaByEstudiante (int idEstudiante){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="select max(idTarea) from Tareas where idAlumno=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idEstudiante);
                ResultSet rs =ps.executeQuery();
                if(rs.next()) status= rs.getInt(1);
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al obtener última tarea agregada");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int ActualizarTareas(Tarea e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                int categoria=2;
                if(e.getProgreso()==100) categoria=1;
                String Q = "update tareas set fecha=?, categoria=?, Progreso=? where idTarea=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, getFecha());
                ps.setInt(2, categoria);
                ps.setInt(3, e.getProgreso());
                ps.setInt(4, e.getIdTarea());
                status=ps.executeUpdate();                
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al actualizar las tareas");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int EliminarTarea(int idTarea){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update tareas set categoria=? where idTarea=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, 0);
                ps.setInt(2, idTarea);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al desactivar la tarea");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int EliminarComentario(int idTarea){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="update comentarios set Cactivo=? where idTarea=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, 2);
                ps.setInt(2, idTarea);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al eliminar el comentario");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int VaciarTareas(int idEstudiante){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update tareas set categoria=? where idAlumno=? and categoria=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, 0);
                ps.setInt(2, idEstudiante);
                ps.setInt(3, 1);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al vaciar las tareas del estudiante");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int CrearSesionEstudio(Sesiones e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="insert into sesiones (noSesiones, fecha, idAlumno) values(?,?,?)";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, e.getNumero());
                ps.setString(2, getFecha());
                ps.setInt(3, e.getIdAlumno());
                status=ps.executeUpdate();
                
                String L="select xp from alumno where idAlumno=?";
                PreparedStatement a = con.prepareStatement(L);
                a.setInt(1, e.getIdAlumno());
                ResultSet rs = a.executeQuery();
                
                if(rs.next()) status=ActualizarXP((rs.getInt(1) + e.getIdSesion()), e.getIdAlumno());
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al crear sesion de estudio");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int ActualizarSesiones(Sesiones e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update sesiones set noSesiones=? where idSesion=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, e.getNumero());
                ps.setInt(2, e.getIdSesion());
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al actualizar la sesion de estudio");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int ActualizarXP(int xp, int idAlumno){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update Alumno set xp=? where idAlumno=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, xp);
                ps.setInt(2, idAlumno);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al actualizar la sesion de estudio");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static List<Vinculo> getAllVinculosByIdEstudiante(int idEstudiante){
        List<Vinculo> lista= new ArrayList<Vinculo>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="select * from vinculos where idAlumno=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idEstudiante);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Vinculo m= new Vinculo();
                    m.setIdVinculo(rs.getInt(1));
                    m.setIdAlumno(rs.getInt(2));
                    m.setIdTutor(rs.getInt(3));
                    m.setActivo(rs.getInt(4));
                    lista.add(m);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener vinculos getAllVinculosById alumno");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static Tutor ObtenerTutorByCodigo (String code){
        Tutor e = new Tutor();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "SELECT * FROM tutor where codigo=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, code);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    e.setIdTutor(rs.getInt(1));
                    e.setIdCuenta(rs.getInt(2));
                    e.setCódigo(rs.getString(3));
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener tutor por código");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static int DesactivarVinculo(int idVinculo){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update vinculos set VActivo=? where idVinculo=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, 0);
                ps.setInt(2, idVinculo);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al Desactivar el vínculo");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int ActivarVinculo(int idVinculo){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="update vinculos set VActivo=? where idVinculo=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, 1);
                ps.setInt(2, idVinculo);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al Activar el vínculo");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static int VincularCuenta(Vinculo e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="insert into vinculos (idAlumno, idTutor, VActivo) values(?,?,?)";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, e.getIdAlumno());
                ps.setInt(2, e.getIdTutor());
                ps.setInt(3, 1);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al crear el vínculo");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
    public static Jefes ObtenerJefeActivo (int idJefe){
        Jefes e = new Jefes();
        try{
            Connection con = ConexiónBD.getConnection();
            String Q = "SELECT * FROM jefes where idJefe=?";
            PreparedStatement ps = con.prepareStatement(Q);
            ps.setInt(1, idJefe);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                e.setIdJefe(rs.getInt(1));
                e.setJefe(rs.getString(2));
                e.setIdAlumno(rs.getInt(3));
                e.setInicio(rs.getString(4));
                e.setFin(rs.getString(5));
                e.setActivo(rs.getInt(6));
                e.setImgJefe(rs.getInt(7));
            }
        }catch(SQLException d){
            System.out.println("Error al obtener estudiante activo");
            System.out.println(d.getMessage());
            System.out.println(Arrays.toString(d.getStackTrace()));
        }        
        return e;
    }
    public static List<Misiones> getMisionesJefe(int idJefe){
        List<Misiones> lista= new ArrayList<Misiones>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="select * from Misiones where idJefe=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idJefe);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Misiones m = new Misiones();
                    m.setIdMision(rs.getInt(1));
                    m.setMision(rs.getString(2));
                    m.setIdJefe(rs.getInt(3));
                    m.setInicio(rs.getString(4));
                    m.setFin(rs.getString(5));
                    m.setAprox(rs.getString(6));
                    m.setActivo(rs.getInt(7));
                    
                    lista.add(m);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener misiones por jefe");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static List<Jefes> getAllJefes(int idAlumno){
        List<Jefes> lista= new ArrayList<Jefes>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "select * from Jefes where idAlumno=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idAlumno);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Jefes m = new Jefes();
                    m.setIdJefe(rs.getInt(1));
                    m.setJefe(rs.getString(2));
                    m.setIdAlumno(rs.getInt(3));
                    m.setInicio(rs.getString(4));
                    m.setFin(rs.getString(5));
                    m.setActivo(rs.getInt(6));
                    m.setImgJefe(rs.getInt(7));
                    System.out.println(rs.getInt(7));
                    
                    lista.add(m);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener los jefes del estudiante");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static int AñadirJefe(Jefes e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q = "insert into Jefes (Jefe, idAlumno, Inicio, Fin, activo, img) values(?,?,?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, e.getJefe());
                ps.setInt(2, e.getIdAlumno());
                ps.setString(3, getFecha());
                ps.setString(4, e.getFin());
                ps.setInt(5, 0);
                ps.setInt(6, e.getImgJefe());
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al Añadir Jefe");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
}