package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DevelopersController {
    @GetMapping("/developers")
    public String searchDevelopers(@RequestParam String start, Model model) {
        model.addAttribute("start", start);
        return "developers";

    }

}



