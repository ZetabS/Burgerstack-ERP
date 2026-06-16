package com.kh.burgerstack.material;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/owner/materials")
public class OwnerMaterialController {

    @Autowired
    private MaterialService materialService;

    @GetMapping("")
    public String selectMaterialList(@RequestParam(value = "materialType", required = false) String materialType,
                                      @RequestParam(value = "keyword", required = false) String keyword,
                                      Model model) {
        ArrayList<Material> materials = materialService.selectMaterialList(materialType, keyword);
        model.addAttribute("materials", materials);
        return "material/materialListBO";
    }

    @GetMapping("/{materialId}/details")
    @ResponseBody
    public String materialDetail(@PathVariable("materialId") Long materialId) {
        return materialService.materialDetail(materialId);
    }
}