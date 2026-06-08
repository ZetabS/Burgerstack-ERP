package com.kh.burgerstack.store;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class OwnerStoreController {

    @Autowired
    private StoreService storeService;

    // 점주 - 점포 목록 조회
    @GetMapping("/owner/store")
    public String ownerStoreList(String status,
                                 Model model) {

        List<StoreListRow> list =
                storeService.selectOwnerStoreList(status);

        model.addAttribute("list", list);
        model.addAttribute("status", status);

        return "owner/storeList";
    }

    // 점주 - 점포 상세 조회
    @GetMapping("/owner/store/{storeId}")
    public String ownerStoreDetail(@PathVariable("storeId") Long storeId,
                                   Model model) {

        Store store = storeService.selectStoreDetail(storeId);

        model.addAttribute("store", store);

        return "owner/storeDetail";
    }
}