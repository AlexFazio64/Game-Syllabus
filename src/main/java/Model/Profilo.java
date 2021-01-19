package Model;

import java.io.File;

public class Profilo {
    private String email;
    private String password;
    private String username;
    private String descrizione;
    private File immagine;


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public File getImmagine() {
        return immagine;
    }

    public void setImmagine(File immagine) {
        this.immagine = immagine;
    }

}
