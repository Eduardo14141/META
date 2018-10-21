package Java;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
/*
* Clase para validar campos web.
* <p>El modo de uso es simple.
* <ol>
*   <li>Instanciar al objeto
*      <pre>Checador validar = new Checador();</pre>
* 
*  <li>Llamar a un metodo para determinar si la cadema es correcta o no y usa el mensaje de error
*      <pre>if(validar.usuario(//Valiable a validar){
*             //Codigo de validacion erronea
*             validar.getMensaje();
*             //Codigo de mensaja de error (opcional)
*      }</pre>
* </ol>
* <p>La clase usa REGEX para validar.
* <p>Cada validacion almacena un valor dentro
* de {@link Checador#mensaje Mensaje} que puede se consultado en
* {@link Checador#getMensaje() getMensaje()}
*/
public class AntiInyeccion {
    private String mensaje;
    private Pattern p;
    private Matcher m;
    private final String vocalesEspañol = "ÁÉÚÍÓáéúíóÄËÏÜÖäëüïö";
    private final String numInt = "[\\d]+";
    private final String numFloat = "[0-9]+([\\.][0-9]+)?";
    private final String alfanumerico = "[\\w"+this.vocalesEspañol+"\\s]+";
    private final String alfabeto = "[A-Za-z"+this.vocalesEspañol+"\\s]+";
    private final String correo = "("+alfanumerico+"\\.?)+\\@("+alfanumerico+"\\.?)+\\."+alfanumerico+"";
    private final String vacio = "[^\\t\\r\\n\\f\\v\\s]"; //que no sea vacía
    private final String comillas = "[\\\"']"; //¿tiene comillas?

    public boolean usuario(String usuario){
        if(this.estaVacio(usuario)) return true;
        if(this.estaMalLongitud(usuario, 2, 15))return true;
        if(this.noEsAlfabetico(usuario))return true;
        this.mensaje = "valido";
        return false;
    }
    public boolean contraseña(String contraseña){
        if(this.estaVacio(contraseña)) return true;
        if(this.estaMalLongitud(contraseña, 8, 30)) return true;
        if(this.noEsAlfanumerico(contraseña)) return true;
        this.mensaje = "valido";
        return false;
    }
    private boolean noEsAlfanumerico(String var){
        if(!this.RegexMatch(alfanumerico, var)){
            this.mensaje = "no es alfanumerico";
            return true;
        }
        return false;
    } 
    private boolean noEsUnCorreo(String var){
        if(!this.RegexMatch(correo, var)){
            this.mensaje = "no es un correo";
            return true;
        }
        return false;
    }
    private boolean tieneComillas(String var){
        if(this.RegexFind(comillas, var)){
            this.mensaje = "no pude contener comillas simples o dobles";
            return true;
        }
        return false;
    }
    private boolean estaVacio(String var){
        if( var == null){
            this.mensaje = "esta vacio";
            return true;
        }else if(!this.RegexFind(vacio, var)){
            this.mensaje = "esta vacio";
            return true;
        }
        return false;
    }
    private boolean estaMalLongitud(String var,int min,int max){
        if (var.length()<min) {
            this.mensaje="no puede ser de longitud menor a "+min;
            return true;
        }else if (var.length()>max) {
            this.mensaje="no puede ser de longitud mayor a "+max;
            return true;
        }
        return false;
    }
    private boolean noEsUnNumeroEntero(String var){
        if(!this.RegexMatch(this.numInt, var)){
            this.mensaje = "no es un número entero";
            return true;
        }
        return false;
    }
    private boolean noEsUnNumeroDecimal(String var){
        if(!this.RegexMatch(this.numFloat, var)){
            this.mensaje = "no es un número decimal";
            return true;
        }
        return false;
    }
    private boolean noEsAlfabetico(String var){
        if(!this.RegexMatch(this.alfabeto, var)){
            this.mensaje = "no contiene solamente caracteres alfabeticos";
            return true;
        }
        return false;
    }
    private boolean RegexMatch(String regex, String var){
        p = Pattern.compile(regex);
        m = p.matcher(var);
        return m.matches();
    }
    private boolean RegexFind(String regex, String var){
        p = Pattern.compile(regex);
        m = p.matcher(var);
        return m.find();
    }
    public String getMensaje() {
        return mensaje;
    }
}