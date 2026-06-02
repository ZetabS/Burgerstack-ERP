package com.kh.burgerstack.material.model.vo;

import java.sql.Date;

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

	private int materialId;			//	MATERIAL_ID	NUMBER
	private String materialCode;	//	MATERIAL_CODE	VARCHAR2(30 BYTE)
	private String materialName;	//	MATERIAL_NAME	VARCHAR2(100 BYTE)
	private String materialType;	//	MATERIAL_TYPE	VARCHAR2(50 BYTE)
	private int costPrice;			//	COST_PRICE	NUMBER(12,0)
	private int sellingPrice;		//	SELLING_PRICE	NUMBER(12,0)
	private int imageFileId;		//	IMAGE_FILE_ID	NUMBER
	private String details;			//	DETAILS VARCHAR2(3000)
	private String status;			//	STATUS	VARCHAR2(20 BYTE)
	private String createdBy;		//	CREATED_BY	NUMBER
	private Date createdAt;			//	CREATED_AT	DATE
	private int updatedBy;			//	UPDATED_BY	NUMBER
	private Date updatedAt;			//	UPDATED_AT	DATE
}
