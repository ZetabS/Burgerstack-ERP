package com.kh.burgerstack.inventory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryListSort;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/owner/inventories")
@RequiredArgsConstructor
public class OwnerInventoryController {
    private final InventoryService inventoryService;

    @GetMapping("")
    public String list(
            InventorySearchCondition condition,
            InventoryListSort inventoryListSort,
            PagingRequest pagingRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryListView inventoryListView = inventoryService.getOwnerInventoryListView(
                condition,
                pagingRequest,
                loginUser);
        model.addAttribute("view", inventoryListView);
        return "inventory/inventoryListViewBO";
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
