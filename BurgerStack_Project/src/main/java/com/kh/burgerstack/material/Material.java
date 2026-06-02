package com.kh.burgerstack.material;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
	private BigDecimal costPrice;
	private BigDecimal sellingPrice;
	private Long imageFileId;
	private String details;
	private String status;
	private Long createdBy;
	private LocalDateTime createdAt;
	private Long updatedBy;
	private LocalDateTime updatedAt;
}
