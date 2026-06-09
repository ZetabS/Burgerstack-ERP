package com.kh.burgerstack.material;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Material {
	private Long materialId;
	private String materialCode;
	private String materialName;
	private String materialType;
	private BigDecimal supplyPrice;
	private String details;
	private String status;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private ArrayList<MaterialFile> materialFiles;

    private String imageFileId;
    
    // 목록/상세 조회 시 이미지 편의 접근용
    public MaterialFile getRepresentativeFile() {
        if (materialFiles != null && !materialFiles.isEmpty()) {
            return materialFiles.get(0);
        }
        return null;
    }
}
