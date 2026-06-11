package com.kh.burgerstack.inquiry;

import java.io.File;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceBO {

	private final InquiryDaoBO inquiryDaoBO;

	public int InquiryEnroll(Inquiry inquiry, MultipartFile uploadFile) {

	    int result = inquiryDaoBO.InquiryEnroll(inquiry);

	    if(result > 0 && !uploadFile.isEmpty()) {

	        String originName = uploadFile.getOriginalFilename();

	        String changeName =
	                System.currentTimeMillis()
	                + "_"
	                + originName;

	        String savePath =
	                "C:/upload/inquiry/";

	        try {

	            File dir = new File(savePath);

	            if(!dir.exists()) {
	                dir.mkdirs();
	            }

	            uploadFile.transferTo(
	                    new File(savePath + changeName));

	            InquiryFile file = new InquiryFile();

	            file.setOriginalName(originName);
	            file.setStoredName(changeName);
	            file.setStoragePath(savePath);
	            file.setAttachTarget("Q");

	            // 문의글 PK 저장
	            file.setInquiryId(inquiry.getInquiryId());

	            inquiryDaoBO.insertInquiryFile(file);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return result;
	}

	public List<Inquiry> InquiryList(Long storeId, String condition, String keyword, int page, int limit) {
        int offset = (page - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);
        return inquiryDaoBO.InquiryList(storeId, condition, keyword, rowBounds);
    }

    public int getTotalCount(Long storeId, String condition, String keyword) {
        return inquiryDaoBO.getTotalCount(storeId, condition, keyword);
    }

	public Inquiry InquiryListDetail(long inquiryId) {
		return inquiryDaoBO.InquiryListDetail(inquiryId);
	}

	public int InquiryEdit(Inquiry i) {
		return inquiryDaoBO.InquiryEdit(i);
	}

	public int InquiryDelete(long inquiryId) {
		return inquiryDaoBO.InquiryDelete(inquiryId);
	}

	
}
