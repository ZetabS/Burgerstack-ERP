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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.dao.DuplicateKeyException;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Controller
@RequestMapping("admin/stores")
public class StoreController {

    @Autowired
    private StoreService storeService;

    // 점포 등록 처리
    @PostMapping("")
    public String insertStore(Store store,
                              String createStockYn,
                              String phone1,
                              String phone2,
                              String phone3,
                              String detailAddress,
                              RedirectAttributes ra) {

        if (store.getOwnerUserNo() == null) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "점주 계정을 선택해주세요.");
            return "redirect:/admin/stores/new";
        }
        
        int ownerStoreCount =
                storeService.countStoreByOwnerUserNo(store.getOwnerUserNo());

        if (ownerStoreCount > 0) {
            store.setOwnerUserNo(null);
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "이미 점포에 연결된 점주입니다.");
            return "redirect:/admin/stores/new";
        }

        int duplicateCount =
                storeService.countStoreName(store.getStoreName());

        if (duplicateCount > 0) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "이미 등록된 점포명입니다.");
            return "redirect:/admin/stores/new";
        }

        phone1 = phone1 == null ? "" : phone1.trim();
        phone2 = phone2 == null ? "" : phone2.trim();
        phone3 = phone3 == null ? "" : phone3.trim();

        if (!phone1.matches("\\d{3}")
                || !phone2.matches("\\d{4}")
                || !phone3.matches("\\d{4}")) {

            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "연락처는 3자리 - 4자리 - 4자리 숫자로 입력해주세요.");
            return "redirect:/admin/stores/new";
        }

        String phone =
                phone1 + "-" + phone2 + "-" + phone3;

        int phoneCount =
                storeService.countStorePhone(phone);

        System.out.println("[점포등록] phone = " + phone);
        System.out.println("[점포등록] phoneCount = " + phoneCount);

        if (phoneCount > 0) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "이미 등록된 연락처입니다.");
            return "redirect:/admin/stores/new";
        }

        String address = store.getAddress();

        if (detailAddress != null && !detailAddress.trim().equals("")) {
            address = address + " " + detailAddress.trim();
        }

        store.setPhone(phone);
        store.setAddress(address);

        int result = storeService.insertStore(store, createStockYn);

        if (result > 0) {
            ra.addFlashAttribute("msg", "점포가 등록되었습니다.");
            return "redirect:/admin/stores";
        }

        return "common/errorPage";
    }
    
    private void keepStoreForm(RedirectAttributes ra,
	            Store store,
	            String phone1,
	            String phone2,
	            String phone3,
	            String detailAddress) {
	
	ra.addFlashAttribute("store", store);
	ra.addFlashAttribute("phone1", phone1);
	ra.addFlashAttribute("phone2", phone2);
	ra.addFlashAttribute("phone3", phone3);
	ra.addFlashAttribute("detailAddress", detailAddress);
	
	if (store.getOwnerUserNo() != null) {
	ra.addFlashAttribute("selectedOwnerText", "선택된 점주 유지됨");
	}
	}

    // 점포 등록 화면
    @GetMapping("new")
    public String storeEnrollForm() {
        return "store/storeEnrollForm";
    }

	 // 점포 목록 조회
	    @GetMapping("")
	    public String selectStoreList(PagingRequest pi,
	                                  String status,
	                                  String keyword,
	                                  String sort,
	                                  Model model) {
	
	        Map<String, String> map = new HashMap<>();
	
	        map.put("status", status);
	        map.put("keyword", keyword);
	        map.put("sort", sort);
	
	        int count = storeService.selectStoreCount(map);
	
	        List<StoreListRow> list = storeService.selectStoreList(map, pi);
	
	        model.addAttribute("count", count);
	        model.addAttribute("pageInfo", pi.toPageInfo(count));
	        model.addAttribute("list", list);
	
	        model.addAttribute("status", status);
	        model.addAttribute("keyword", keyword);
	        model.addAttribute("sort", sort);
	
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
	    @PostMapping("/{storeId}/update")
	    public String updateStore(@PathVariable("storeId") Long storeId,
	                              Store store,
	                              RedirectAttributes ra) {
	
	        store.setStoreId(storeId);
	
	        if (store.getPhone() == null
	                || !store.getPhone().matches("\\d{3}-\\d{4}-\\d{4}")) {
	
	            ra.addFlashAttribute("msg", "연락처는 3자리-4자리-4자리 형식으로 입력해주세요.");
	            return "redirect:/admin/stores/" + storeId;
	        }
	
	        if ("OPEN".equals(store.getStatus())) {
	            int phoneCount =
	                    storeService.countStorePhoneForUpdate(store);
	
	            System.out.println("[점포수정] storeId = " + storeId);
	            System.out.println("[점포수정] phone = " + store.getPhone());
	            System.out.println("[점포수정] phoneCount = " + phoneCount);
	
	            if (phoneCount > 0) {
	                ra.addFlashAttribute("msg", "이미 등록된 연락처입니다.");
	                return "redirect:/admin/stores/" + storeId;
	            }
	        }
	
	        try {
	            int result = storeService.updateStore(store);
	
	            if (result > 0) {
	                ra.addFlashAttribute("msg", "점포 정보가 수정되었습니다.");
	                return "redirect:/admin/stores/" + storeId;
	            }
	
	        } catch (DuplicateKeyException e) {
	            ra.addFlashAttribute("msg", "이미 등록된 연락처입니다.");
	            return "redirect:/admin/stores/" + storeId;
	        }
	
	        return "common/errorPage";
	    }
	    
	    @GetMapping("/owners/search")
	    @ResponseBody
	    public Map<String, Object> searchOwner(String keyword) {

	        Map<String, Object> result = new HashMap<>();

	        Map<String, Object> owner =
	                storeService.selectOwnerByLoginId(keyword);

	        if (owner == null) {
	            result.put("found", false);
	            return result;
	        }

	        result.put("found", true);
	        result.put("ownerUserNo", owner.get("ownerUserNo"));
	        result.put("ownerLoginId", owner.get("ownerLoginId"));
	        result.put("ownerName", owner.get("ownerName"));

	        return result;
	    }

    /*
     * 폐점 처리 버튼을 없앨 거면 이 메서드는 이제 필요 없음.
     * 상태 select에서 CLOSED로 바꾸고 수정 버튼을 누르면 updateStore에서 처리됨.
     */
}