package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import Model.Recensione;
import persistence.DAO.JDBC.RecensioneDAOPG;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class GameController {
    @GetMapping("/game")
    public String loadGame(@RequestParam String id, Model model, HttpSession session) {
        ArrayList<Recensione> reviews = new RecensioneDAOPG().findAllByIdGame(id);
        String email = null;
        Recensione review = null;
        if (session.getAttribute("emailLogged") != null) {
            email = session.getAttribute("emailLogged").toString();
            review = new RecensioneDAOPG().findReviewByEmail(email, id);
            model.addAttribute("personalReview", review);
            model.addAttribute("emailLogged",email);
        }
        model.addAttribute("game", id);
        model.addAttribute("reviews", reviews);
        return "game";
    }


}
