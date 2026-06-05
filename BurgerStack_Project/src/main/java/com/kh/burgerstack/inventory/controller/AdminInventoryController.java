package com.kh.burgerstack.inventory.controller;

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
import com.kh.burgerstack.inventory.service.InventoryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/inventories")
@RequiredArgsConstructor
public class AdminInventoryController {
    private final InventoryService inventoryService;

    @GetMapping("")
    public String list(
            InventorySearchCondition condition,
            InventoryListSort inventoryListSort,
            PagingRequest pagingRequest,
            Model model) {
        InventoryListView inventoryListView = inventoryService.getInventoryListView(
                condition,
                pagingRequest);
        model.addAttribute("view", inventoryListView);
        return "inventory/inventoryListViewHO";
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
