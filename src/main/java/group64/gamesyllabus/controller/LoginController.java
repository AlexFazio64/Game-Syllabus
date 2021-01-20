package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import persistence.DAO.JDBC.ProfiloDAOPG;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @PostMapping("/doLogin")
    public String login(HttpSession session, @RequestParam String email, @RequestParam String password) {
        if (loginOk(email, password)) {
            session.setAttribute("emailLogged", email);
            System.out.println(session.getAttribute("emailLogged"));
            return "index";
        }else {
            return "regPage";
        }
    }

    @GetMapping("doLogout")
    public String logout(HttpSession session) {
        session.invalidate();

        return "index";
//		return "logoutSuccess";
    }

    private boolean loginOk(String email, String password) {
        ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
        Profilo profilo = profiloDAOPG.findByPrimaryKey(email);

        if (profilo != null){
            if (profilo.getEmail().equals(email) && profilo.getPassword().equals(password))
                return true;
        }
        return false;
    }
}
