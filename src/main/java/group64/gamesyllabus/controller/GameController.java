package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class GameController {
    @GetMapping("/game")
    public String loadGame(@RequestParam String name, Model model) {
        model.addAttribute("game",name);

        return "game";
    }


}
