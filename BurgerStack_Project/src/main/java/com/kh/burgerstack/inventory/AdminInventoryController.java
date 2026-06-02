package com.kh.burgerstack.inventory;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/inventories")
public class AdminInventoryController {
    @GetMapping("/")
    @ResponseBody
    public String list(Long storeId, boolean belowSafetyStock) {
        return "";
    }

    @GetMapping("/{inventoryId}/edit")
    public String adjustForm(@PathVariable Long inventoryId, Long quentity) {
        return "";
    }

    @PostMapping("/{inventoryId}")
    public String adjust(@PathVariable Long inventoryId, Long quentity) {
        return "";
    }
}
