package com.kh.burgerstack.material;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // ⭐️ 추가
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping; // ⭐️ 추가
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/owner/materials")
public class OwnerMaterialController {

    @Autowired
    private MaterialService materialService;

    @GetMapping("")
    public String selectMaterialList(Model model) {
        ArrayList<Material> list = materialService.selectMaterialList();
        model.addAttribute("materials", list);
        return "material/materialListBO"; 
    }

    @GetMapping("/detail")
    @ResponseBody
    public Material materialDetail(@RequestParam("materialId") Long materialId) {
        return materialService.materialDetail(materialId);
    }
}