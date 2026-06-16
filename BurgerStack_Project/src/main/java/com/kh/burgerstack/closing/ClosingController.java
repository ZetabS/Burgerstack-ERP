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

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;

@Controller
public class ClosingController {
    private final ClosingService closingService;

    public ClosingController(ClosingService closingService) {
        this.closingService = closingService;
    }

    @GetMapping("/owner/closings")
    public String ownerClosingList(@RequestParam(required = false, defaultValue = "") String startDate,
            @RequestParam(required = false, defaultValue = "") String endDate,
            Model model) {
        Long storeId = 1L;

        List<StoreClosing> list = closingService.selectOwnerClosingList(storeId, startDate, endDate);

        model.addAttribute("list", list);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "owner/closing/closingListView";
    }

    @GetMapping("/admin/closings")
    public String adminClosingList(@RequestParam(required = false) Long storeId,
            @RequestParam(required = false, defaultValue = "") String startDate,
            @RequestParam(required = false, defaultValue = "") String endDate,
            @RequestParam(required = false, defaultValue = "") String keyword,
            Model model) {
        List<StoreClosing> list = closingService.selectAdminClosingList(
                storeId,
                startDate,
                endDate,
                keyword);

        model.addAttribute("list", list);
        model.addAttribute("storeId", storeId);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("keyword", keyword);

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
                closingService.selectClosingInventoryList(storeId));

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
            RedirectAttributes ra,
            HttpSession session) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        Long storeId = loginUser.getStoreId();

        StoreClosing closing = new StoreClosing();
        closing.setBusinessDate(LocalDate.parse(businessDate));
        closing.setClosingMemo(closingMemo);
        closing.setStoreId(storeId);

        List<StoreClosingItem> itemList = new ArrayList<>();

        for (int i = 0; i < storeInventoryId.size(); i++) {

            Long systemQty = systemQuantity.get(i);
            Long useQty = physicalQuantity.get(i);
            Long disposalQty = disposalQuantity.get(i);

            if (systemQty == null) {
                systemQty = 0L;
            }

            if (useQty == null) {
                useQty = 0L;
            }

            if (disposalQty == null) {
                disposalQty = 0L;
            }

            String memo = null;

            if (closingItemMemo != null && closingItemMemo.size() > i) {
                memo = closingItemMemo.get(i);

                if (memo != null) {
                    memo = memo.trim();
                }
            }

            String materialName = materialNameSnapshot.get(i);

            if (useQty + disposalQty > systemQty) {
                ra.addFlashAttribute(
                        "msg",
                        materialName + "의 실사용수량과 폐기 수량의 합은 전산재고보다 클 수 없습니다.");
                return "redirect:/owner/closings/new";
            }

            if (disposalQty > 0 && (memo == null || memo.equals(""))) {
                ra.addFlashAttribute(
                        "msg",
                        materialName + "의 폐기 사유를 입력해주세요.");
                return "redirect:/owner/closings/new";
            }

            if (disposalQty == 0) {
                memo = null;
            }

            StoreClosingItem item = new StoreClosingItem();

            item.setStoreInventoryId(storeInventoryId.get(i));
            item.setSystemQuantity(systemQty);
            item.setMaterialNameSnapshot(materialName);
            item.setPhysicalQuantity(useQty);
            item.setDisposalQuantity(disposalQty);
            item.setClosingItemMemo(memo);

            itemList.add(item);
        }

        try {
            closingService.insertClosing(closing, itemList, loginUser);
            ra.addFlashAttribute("msg", "마감이 등록되었습니다.");
        } catch (DuplicateKeyException e) {
            ra.addFlashAttribute("msg", "이미 마감된 영업일입니다.");
            return "redirect:/owner/closings/new";
        }

        return "redirect:/owner/closings";
    }
}