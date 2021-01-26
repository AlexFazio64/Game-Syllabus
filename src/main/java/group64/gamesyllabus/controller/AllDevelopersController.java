package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AllDevelopersController {
    @GetMapping("/developers")
    public String firstPage(@RequestParam String start, Model model) {
        model.addAttribute("start", start);
        return "allDevelopers";

    }

    @GetMapping("/developers/next")
    public String next(@RequestParam String start, @RequestParam String previous, Model model) {
        model.addAttribute("start", start);
        model.addAttribute("previous",previous);
        return "allDevelopers";
    }
}



