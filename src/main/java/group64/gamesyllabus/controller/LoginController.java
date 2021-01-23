package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import persistence.DAO.JDBC.ProfiloDAOPG;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    //Login post request
    @PostMapping("/doLogin")
    public String login(HttpSession session, @RequestParam String email, @RequestParam String password) {
        if (loginOk(email, password)) {
            ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
            session.setAttribute("usernameLogged",profiloDAOPG.findByPrimaryKey(email).getUsername());
            session.setAttribute("emailLogged", email);
            return "redirect:/index";
        } else {
            Boolean error = true;
            session.setAttribute("error", true);
            return "redirect:/index";
        }
    }

    //Login after registration need a get request
    @GetMapping("/doLogin")
    public String loginAfterReg(HttpSession session) {
        if (loginOk(session.getAttribute("email").toString(), session.getAttribute("password").toString())) {
            ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
            session.setAttribute("usernameLogged", profiloDAOPG.findByPrimaryKey(session.getAttribute("email").toString()).getUsername());
            session.setAttribute("emailLogged", session.getAttribute("email").toString());
            return "redirect:/index";
        } else {
            Boolean error = true;
            session.setAttribute("error", true);
            return "redirect:/index";
        }
    }

    //Logout from session
    @GetMapping("doLogout")
    public String logout(HttpSession session) {
        session.invalidate();

        return "redirect:/index";
    }
    //Check if DB has the credentials
    private boolean loginOk(String email, String password) {
        ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
        Profilo profilo = profiloDAOPG.findByPrimaryKey(email);
        //controllo se la password criptata è giusta
        if (profilo != null) {
            return profilo.getEmail().equals(email) && BCrypt.checkpw(password, profilo.getPassword());
        }
        return false;
    }
}
