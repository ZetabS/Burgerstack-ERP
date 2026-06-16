package com.kh.burgerstack.material;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.burgerstack.common.template.XssDefencePolicy;
import com.kh.burgerstack.file.FileStore;
import com.kh.burgerstack.file.StoredFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/materials")
public class MaterialController {

    @Autowired
    private MaterialService materialService;


    @GetMapping("new")
    public String materialEnrollform() {
        return "material/materialEnrollForm";
    }

    /**
     * 자재 등록
     */
    @PostMapping({"", "/"})
    public String materialInsert(
            Material m,
            @RequestParam(value = "materialImage", required = false) MultipartFile imageFile,
            HttpSession session) {

        try {
            // XSS 방어
            m.setMaterialName(XssDefencePolicy.defence(m.getMaterialName()));
            if (m.getDetails() != null) {
                m.setDetails(XssDefencePolicy.defence(m.getDetails()));
            }

            // 통합 서비스 메소드 호출
            materialService.materialInsert(m, imageFile);

            session.setAttribute("alertMsg", "자재 등록이 완료되었습니다.");
            return "redirect:/admin/materials";

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertMsg", "등록 중 오류가 발생했습니다.");
            return "redirect:/admin/materials/new";
        }
    }

    /**
     * 전체 목록 조회
     */
    @GetMapping("")
    public String selectMaterialList(@RequestParam(value = "materialType", required = false) String materialType,
                                      @RequestParam(value = "keyword", required = false) String keyword,
                                      Model model) {
        ArrayList<Material> materials = materialService.selectMaterialList(materialType, keyword);
        model.addAttribute("materials", materials);
        return "material/materialListHO";
    }


    /**
     * 상세 조회 (AJAX)
     */
    @GetMapping("/{materialId}/details")
    @ResponseBody
    public String materialDetail(@PathVariable("materialId") Long materialId) {
        return materialService.materialDetail(materialId);
    }

    /**
     * 수정 화면
     */
    @GetMapping("{materialId}/edit")
    public String materialEdit(@PathVariable("materialId") Long materialId, Model model) {
        Material material = materialService.selectMaterial(materialId);
        model.addAttribute("material", material);
        return "material/materialEnrollForm";
    }

    /**
     * 자재 수정
     */
    @PostMapping("{materialId}")
    public String updateMaterial(
            @PathVariable("materialId") Long materialId,
            @ModelAttribute Material m,
            @RequestParam(value = "materialImage", required = false) MultipartFile imageFile,
            HttpSession session) {

        m.setMaterialId(materialId);

        // XSS 방어
        m.setMaterialName(XssDefencePolicy.defence(m.getMaterialName()));
        if (m.getDetails() != null) {
            m.setDetails(XssDefencePolicy.defence(m.getDetails()));
        }

        // 서비스 호출
        boolean isSuccess = materialService.updateMaterial(m, imageFile);
        
        if (isSuccess) {
            session.setAttribute("alertMsg", "수정 성공!");
        } else {
            session.setAttribute("alertMsg", "수정 실패!");
        }
        return "redirect:/admin/materials";
    }

    /**
     * 자재 삭제 (INACTIVE 처리)
     */
    /*
    @PostMapping("{materialId}/status")
    public String deleteMaterial(@PathVariable("materialId") Long materialId, Model model, HttpSession session) {
    	int result = materialService.deleteMaterial(materialId);
        if (result > 0) {
            session.setAttribute("alertMsg", "자재가 삭제되었습니다.");
            return "redirect:/admin/materials";
        } else {
            model.addAttribute("errorMsg", "자재 정보 삭제에 실패했습니다.");
            return "common/errorPage";
        }
    }
    */
    
}
