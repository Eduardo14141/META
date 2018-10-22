package TablasSQL;
public class Jefes {
    private int idJefe, idAlumno, activo, imgJefe;
    private String Jefe, inicio, fin;

    public int getIdJefe() {
        return idJefe;
    }
    public void setIdJefe(int idJefe) {
        this.idJefe = idJefe;
    }
    public int getIdAlumno() {
        return idAlumno;
    }
    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }
    public String getJefe() {
        return Jefe;
    }
    public void setJefe(String Jefe) {
        this.Jefe = Jefe;
    }
    public String getInicio() {
        return inicio;
    }
    public void setInicio(String inicio) {
        this.inicio = inicio;
    }
    public String getFin() {
        return fin;
    }
    public void setFin(String fin) {
        this.fin = fin;
    }
    public int getActivo() {
        return activo;
    }
    public void setActivo(int activo) {
        this.activo = activo;
    }
    public int getImgJefe() {
        return imgJefe;
    }
    public void setImgJefe(int imgJefe) {
        this.imgJefe = imgJefe;
    }   
}