package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import Model.Recensione;
import Model.ListaGiochi;
import persistence.DAO.JDBC.ListaGiochiDAOPG;
import persistence.DAO.JDBC.RecensioneDAOPG;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class GameController {
    @GetMapping("/removeFrom")
    public String removeFromList(@RequestParam String id, HttpSession session) {
        if (session.getAttribute("emailLogged") != null) {
            String email = session.getAttribute("emailLogged").toString();
            new ListaGiochiDAOPG().delete(email, id);
        }
        return "redirect:/game?id=" + id;
    }

    @GetMapping("/addTo")
    public String addToList(@RequestParam String id, HttpSession session) {
        if (session.getAttribute("emailLogged") != null) {
            String email = session.getAttribute("emailLogged").toString();
            new ListaGiochiDAOPG().save(email, id);
            session.setAttribute("newInList", new String("new game"));
        }
        return "redirect:/game?id=" + id;
    }


    @GetMapping("/Review")
    public String saveReview(@RequestParam String id, Model model, HttpSession session, @RequestParam String
            rating, @RequestParam String text) {
        if (session.getAttribute("emailLogged") != null) {
            String email = session.getAttribute("emailLogged").toString();
            Recensione review = new Recensione();
            review.setIdGioco(id);
            review.setScrittoDa(email);
            review.setValutazione(Integer.valueOf(rating));
            review.setTesto(text);
            model.addAttribute("personalReview", review);
            model.addAttribute("emailLogged", email);
            boolean newReview = new RecensioneDAOPG().save(review);
        }
        return "redirect:/game?id=" + id;
    }

    @GetMapping("/game")
    public String loadGame(@RequestParam String id, Model model, HttpSession session) {

        ArrayList<Recensione> reviews = new RecensioneDAOPG().findAllByIdGame(id);
        int sum = 0;
        if (reviews.size() > 0) {
            for (int i = 0; i < reviews.size(); i++) {
                sum += reviews.get(i).getValutazione();
            }
            sum /= reviews.size();
        }
        model.addAttribute("averageRate", sum);
        String email = null;
        Recensione review = null;
        model.addAttribute("game", id);
        if (session.getAttribute("emailLogged") != null) {
            email = session.getAttribute("emailLogged").toString();
            review = new RecensioneDAOPG().findReviewByEmail(email, id);
            model.addAttribute("personalReview", review);
            model.addAttribute("emailLogged", email);
            model.addAttribute("reviews", reviews);
            boolean alreadyInList = false;
            ArrayList<ListaGiochi> games = new ListaGiochiDAOPG().findByPrimaryKey(email);
            for (int i = 0; i < games.size(); i++) {
                if (games.get(i).getIdGioco().equals(id))
                    alreadyInList = true;
            }

            if (alreadyInList) {
                model.addAttribute("intoList", "OK");
            }
            if (session.getAttribute("newInList") != null) {
                model.addAttribute("added", "ok");
                session.removeAttribute("newInList");
            }
        }
        return "game";
    }
}
