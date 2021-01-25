package group64.gamesyllabus.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@org.springframework.stereotype.Controller


public class AllPlatformsController {

    @GetMapping("/platforms")
    public String genreChoose(@RequestParam String start, Model model) {
        model.addAttribute("start", start);
        return "allPlatforms";
    }
}
