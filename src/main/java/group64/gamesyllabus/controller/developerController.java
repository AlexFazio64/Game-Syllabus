package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class developerController {

    @GetMapping("/developer")
    public String loadDeveloper(@RequestParam String name, Model model){
            model.addAttribute("developer", name);

        return "developer";
    }

}
