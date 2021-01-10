package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class GameController {
    @GetMapping("/game.html")
    public String iscrivi(@RequestParam String name, Model model) {
        System.out.println(name);
        model.addAttribute("game",name);
        return "game";
    }


}
