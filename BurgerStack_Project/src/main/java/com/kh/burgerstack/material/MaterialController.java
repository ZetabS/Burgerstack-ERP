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
// import com.kh.burgerstack.file.FileService;
import com.kh.burgerstack.file.StoredFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping({ "/owner/materials", "/admin/materials" })
public class MaterialController {

	@Autowired
	private MaterialService materialService;
	@Autowired
	// private FileService fileService;
	
	
	
	/**
	 * 자재 등록용 화면
	 * @return
	 */
	@GetMapping("new")
	public String materialEnrollform() {
		return "material/materialEnrollForm";
	} //materialEnrollForm
	
	
	/**
	 * 자재 등록용 컨트롤러
	 * @param m			=> 등록할 내용이 담긴 커맨드객체
	 * @param imageFile => 등록할 이미지
	 * @param session
	 * @return
	 */
	@PostMapping({"", "/"})
	public String materialInsert(
	        Material m,
	        @RequestParam(value = "materialImage", required = false) MultipartFile imageFile,
	        HttpSession session) {

	    try {
	        // 1. 파일 저장
	        if (imageFile != null && !imageFile.isEmpty()) {
	            // StoredFile storedFile = fileService.storeFile(imageFile, m.getCreatedBy());
	            // m.setImageFileId(storedFile.getFileId());
	        }

	        // 2. XSS 방어
	        m.setMaterialName(XssDefencePolicy.defence(m.getMaterialName()));
	        if (m.getDetails() != null) {
	            m.setDetails(XssDefencePolicy.defence(m.getDetails()));
	        }

	        // 3. DB 등록
	        int result = materialService.materialInsert(m);

	        if (result > 0) {
	            session.setAttribute("alertMsg", "자재가 성공적으로 등록되었습니다.");
	            return "redirect:/admin/materials";
	        } else {
	            session.setAttribute("alertMsg", "자재 등록에 실패했습니다.");
	            return "redirect:/admin/materials/new";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        session.setAttribute("alertMsg", "등록 중 오류가 발생했습니다.");
	        return "redirect:/admin/materials/new";
	    }
	} //materialInsert
	
	/**
	 * 전체 목록 조회용
	 * @param model
	 * @return
	 */
	@GetMapping("")
	public String selectMaterialList(Model model) {
		// > 전체 목록 보기용 페이지.
		// materialType, materialName, imageFileId 필요
		// > materialName, imageFileId 는 화면 출력에 사용
		// > materialType 은 상품 분류에 사용
		ArrayList<Material> list = materialService.selectMaterialList(); 
		// System.out.println(list.get(0).getImageFileId());
        model.addAttribute("materials", list);
		return "material/materialListHO";
	}
	
	/**
	 * 상세 정보 조회용
	 * @param materialId
	 * @return
	 */
	@GetMapping("detail")
	@ResponseBody // 💡 페이지 이동이 아니라 데이터를 반환하기 위해 필수 지정!
	public Material materialDetail(@RequestParam("materialId") Long materialId) {
	    
	    // 1. 서비스 단을 통해 DB에서 자재 단건 조회 수행
	    Material material = materialService.materialDetail(materialId);
	    
	    // 2. 조회된 Material 객체를 그대로 리턴하면 
	    // 스프링의 Jackson 라이브러리가 자동으로 {} 형태의 JSON 구조로 변환해 AJAX로 보내줍니다.
	    return material; 
	} //materialDetail
	
	/**
	 * 수정 내용 입력 화면
	 * @param materialId
	 * @param model
	 * @return
	 */
	@GetMapping("{materialId}/edit") // 💡 경로에 {materialId} 가변인자 추가
	public String materialEdit(@PathVariable("materialId") Long materialId, Model model) {
	    
	    // EnrollForm 재사용
		Material material = materialService.materialDetail(materialId); 
	    
	    model.addAttribute("material", material);
	    
	    return "material/materialEnrollForm";
	}
	
	/**
	 * 자재 내용 수정용 
	 * @param pathMaterialId
	 * @param m
	 * @param imageFile
	 * @param model
	 * @return
	 */
	@PostMapping({"{materialId}"})
	public String updateMaterial(
	        @PathVariable(value = "materialId", required = false) Long pathMaterialId,
	        @ModelAttribute Material m,
	        @RequestParam(value = "materialImage", required = false) MultipartFile imageFile,
	        Model model) {
	    
	    Long finalMaterialId = (pathMaterialId != null) ? pathMaterialId : m.getMaterialId();
	    System.out.println("finalMaterialId : " + finalMaterialId);
	    System.out.println("getMaterialId : " + m.getMaterialId());
	    if (finalMaterialId == null) {
	        model.addAttribute("errorMsg", "수정할 자재의 식별 번호(ID)가 누락되었습니다.");
	        return "common/errorPage";
	    }
	    m.setMaterialId(finalMaterialId);
	    
	    // 💡 이미지 업로드 및 기존 이미지 유지 로직
	    if (imageFile != null && !imageFile.isEmpty()) {
	        // 새 이미지를 업로드한 경우
	        // StoredFile storedFile = fileService.storeFile(imageFile, m.getCreatedBy());
	        // m.setImageFileId(storedFile.getFileId());
	    } else {
	        // 새 이미지를 올리지 않은 경우 -> DB에서 기존 정보를 꺼내와서 파일 ID를 복원
	        Material existingMaterial = materialService.selectMaterial(finalMaterialId);
	        if (existingMaterial != null) {
	            // m.setImageFileId(existingMaterial.getImageFileId());
	        }
	    }
	    
	    // 3. XSS 방어 적용
	    if (m.getMaterialName() != null) {
	        m.setMaterialName(XssDefencePolicy.defence(m.getMaterialName()));
	    }
	    if (m.getDetails() != null) {
	        m.setDetails(XssDefencePolicy.defence(m.getDetails()));
	    }
	    
	    // 4. DB 업데이트 실행
	    int result = materialService.updateMaterial(m);
	    System.out.println(result);
	    if (result > 0) {
	        return "redirect:/admin/materials"; 
	    } else {
	        model.addAttribute("errorMsg", "자재 정보 수정에 실패했습니다.");
	        return "common/errorPage";
	    }
	} //updateMaterial
	
	@PostMapping("{materialId}/status")
	public String deleteMaterial(@PathVariable("materialId") Long materialId, Model model, HttpSession session) {
		
	    int result = materialService.deleteMaterial(materialId);
	    
	    if (result > 0) {
	        session.setAttribute("alertMsg", "자재가 성공적으로 삭제되었습니다.");
	        return "redirect:/admin/materials";
	    } else {
	        model.addAttribute("errorMsg", "자재 정보 삭제에 실패했습니다.");
	        return "common/errorPage";
	    }
	}
	
}
