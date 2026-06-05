package com.kh.burgerstack.material;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.kh.burgerstack.file.StoredFile;

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
	
	private StoredFile storedFile;
}
