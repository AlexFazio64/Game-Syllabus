package group64.gamesyllabus.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SearchController {
    @GetMapping("/search")
    public String loadResearch(@RequestParam String name, Model model) {
        model.addAttribute("search", name);

        return "search";
    }
}
