package com.kh.burgerstack.closing;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ClosingController {

    private final ClosingService closingService;

    public ClosingController(ClosingService closingService) {
        this.closingService = closingService;
    }

    @GetMapping("/owner/closings")
    public String ownerClosingList(Model model){

        Long storeId = 1L;

        List<StoreClosing> list =
                closingService.selectOwnerClosingList(storeId);

        System.out.println("점주 마감 개수 : " + list.size());

        model.addAttribute("list", list);

        return "owner/closing/closingListView";
    }

    @GetMapping("/admin/closings")
    public String adminClosingList(
            @RequestParam(required = false) Long storeId,
            Model model) {

        List<StoreClosing> list;

        if (storeId != null) {
            list = closingService.selectAdminClosingListByStoreId(storeId);
        } else {
            list = closingService.selectAdminClosingList();
        }

        model.addAttribute("list", list);
        model.addAttribute("storeId", storeId);

        return "admin/closing/closingListView";
    }
    
    @GetMapping("/owner/closings/{closingId}")
    public String ownerClosingDetail(
            @PathVariable Long closingId,
            Model model) {

        model.addAttribute("closing", closingService.selectClosing(closingId));
        model.addAttribute("itemList", closingService.selectClosingItemList(closingId));

        return "owner/closing/closingDetailView";
    }

    @GetMapping("/admin/closings/{closingId}")
    public String adminClosingDetail(
            @PathVariable Long closingId,
            Model model) {

        model.addAttribute("closing", closingService.selectClosing(closingId));
        model.addAttribute("itemList", closingService.selectClosingItemList(closingId));

        return "admin/closing/closingDetailView";
    }
    
    @GetMapping("/owner/closings/new")
    public String closingEnrollForm(Model model) {

        Long storeId = 1L; // 나중에 로그인 세션에서 꺼내기

        model.addAttribute(
                "inventoryList",
                closingService.selectClosingInventoryList(storeId)
        );

        return "owner/closing/closingEnrollForm";
    }
    
    @PostMapping("/owner/closings")
    public String insertClosing(
            @RequestParam String businessDate,
            @RequestParam String closingMemo,
            @RequestParam List<Long> storeInventoryId,
            @RequestParam List<Long> systemQuantity,
            @RequestParam List<String> materialNameSnapshot,
            @RequestParam List<Long> physicalQuantity,
            @RequestParam List<Long> disposalQuantity,
            @RequestParam(required = false) List<String> closingItemMemo,
            RedirectAttributes ra) {

        Long storeId = 1L; // 나중에 로그인 세션에서 꺼내기

        StoreClosing closing = new StoreClosing();
        closing.setBusinessDate(LocalDate.parse(businessDate));
        closing.setClosingMemo(closingMemo);
        closing.setStoreId(storeId);

        List<StoreClosingItem> itemList = new ArrayList<>();

        for (int i = 0; i < storeInventoryId.size(); i++) {

            StoreClosingItem item = new StoreClosingItem();

            item.setStoreInventoryId(storeInventoryId.get(i));
            item.setSystemQuantity(systemQuantity.get(i));
            item.setMaterialNameSnapshot(materialNameSnapshot.get(i));
            item.setPhysicalQuantity(physicalQuantity.get(i));
            item.setDisposalQuantity(disposalQuantity.get(i));

            String memo = null;

            if (closingItemMemo != null && closingItemMemo.size() > i) {
                memo = closingItemMemo.get(i);
            }

            item.setClosingItemMemo(memo);

            itemList.add(item);
        }

        try {
            closingService.insertClosing(closing, itemList);
            ra.addFlashAttribute("msg", "마감이 등록되었습니다.");
        } catch (DuplicateKeyException e) {
            ra.addFlashAttribute("msg", "이미 마감된 영업일입니다.");
            return "redirect:/owner/closings/new";
        }

        return "redirect:/owner/closings";
    }
    
    
    
    
    
    
    
    
    
    
    
    
}