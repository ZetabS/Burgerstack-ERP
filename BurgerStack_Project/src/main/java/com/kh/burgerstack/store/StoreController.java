package com.kh.burgerstack.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Controller
@RequestMapping("admin/stores")
public class StoreController {

    @Autowired
    private StoreService storeService;

    // 점포 등록 처리
    @PostMapping("")
    public String insertStore(Store store,
                              String createStockYn) {

        int result = storeService.insertStore(store, createStockYn);

        if(result > 0) {
            return "redirect:/admin/stores";
        } else {
            return "common/errorPage";
        }
    }

    // 점포 등록 화면
    @GetMapping("new")
    public String storeEnrollForm() {
        return "store/storeEnrollForm";
    }

    // 점포 목록 조회
    @GetMapping("")
    public String selectStoreList(
            PagingRequest pi,
            String status,
            String startDate,
            String endDate,
            String keyword,
            Model model) {

        Map<String, String> map = new HashMap<>();

        map.put("status", status);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("keyword", keyword);

        int count = storeService.selectStoreCount(map);

        List<StoreListRow> list = storeService.selectStoreList(map, pi);

        model.addAttribute("count", count);
        model.addAttribute("pageInfo", pi.toPageInfo(count));
        model.addAttribute("list", list);

        return "store/storeList";
    }

 
    // 점포 상세 조회
    @GetMapping("/{storeId}")
    public String selectStoreDetail(@PathVariable("storeId") Long storeId,
                                    Model model) {

        Store store = storeService.selectStoreDetail(storeId);

        model.addAttribute("store", store);

        return "store/storeDetail";
    }

    // 점포 수정 처리
    @PostMapping("/{storeId}")
    public String updateStore(@PathVariable("storeId") Long storeId,
                              Store store) {

        store.setStoreId(storeId);

        int result = storeService.updateStore(store);

        if(result > 0) {
            return "redirect:/admin/stores";
        }

        return "common/errorPage";
    }

    @GetMapping("/{storeId}/status")
    public String deleteStore(
            @PathVariable("storeId") Long storeId) {

        int result = storeService.deleteStore(storeId);

        if(result > 0) {
            return "redirect:/admin/stores";
        }

        return "common/errorPage";
    }
}