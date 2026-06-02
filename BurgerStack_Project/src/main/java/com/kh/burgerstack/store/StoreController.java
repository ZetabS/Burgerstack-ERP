package com.kh.burgerstack.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.burgerstack.common.model.vo.PageInfo;
import com.kh.burgerstack.common.template.Pagination;
import com.kh.burgerstack.store.StoreService;
import com.kh.burgerstack.store.SelectStoreList;
import com.kh.burgerstack.store.Store;

@Controller
@RequestMapping("/store")
public class StoreController {

    @Autowired
    private StoreService storeService;

    // 점포 등록 처리
    @PostMapping("/insertStore")
    public String insertStore(Store store,
                              String createStockYn) {

        int result = storeService.insertStore(store, createStockYn);

        if(result > 0) {
            return "redirect:/store/list";
        } else {
            return "common/errorPage";
        }
    }

    // 점포 등록 화면
    @GetMapping("/enroll")
    public String storeEnrollForm() {
        return "store/storeEnrollForm";
    }

    // 점포 목록 조회
    @GetMapping("/list")
    public String selectStoreList(
            @RequestParam(value="currentPage", defaultValue="1") int currentPage,
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

        PageInfo pi = Pagination.getPageInfo(count, currentPage, 10, 10);

        List<SelectStoreList> list =
                storeService.selectStoreList(map, pi);

        model.addAttribute("count", count);
        model.addAttribute("pi", pi);
        model.addAttribute("list", list);

        return "store/storeListView";
    }

    // 점포 상세 조회
    @GetMapping("/detail")
    public String selectStoreDetail(@RequestParam("storeId") int storeId,
                                    Model model) {

        Store store = storeService.selectStoreDetail(storeId);

        model.addAttribute("store", store);

        return "store/storeDetail";
    }

    // 점포 수정 처리
    @PostMapping("/update")
    public String updateStore(Store store) {

        storeService.updateStore(store);

        return "redirect:/store/list";
    }

    // 점포 폐점 처리
    @GetMapping("/delete")
    public String deleteStore(@RequestParam int storeId) {

        storeService.deleteStore(storeId);

        return "redirect:/store/list";
    }
}