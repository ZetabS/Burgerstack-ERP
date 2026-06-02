package com.kh.burgerstack.inventory;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/owner/inventories")
public class OwnerInventoryController {
    @GetMapping("/")
    public String list(boolean belowSafetyStock) {
        return "";
    }

    @GetMapping("/{inventoryId}/edit")
    public String adjustForm(@PathVariable Long inventoryId) {
        return "";
    }

    @PostMapping("/{inventoryId}")
    public String adjust(@PathVariable Long inventoryId) {
        return "";
    }
}
