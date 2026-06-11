package com.kh.burgerstack.inquiry;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceHO {

	private final InquiryDaoHO inquiryDaoHO;

	public List<Inquiry> InquiryList(String condition, String keyword, int page, int limit) {
        int offset = (page - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);
        return inquiryDaoHO.InquiryList(condition, keyword, rowBounds);
    }

    public int getTotalCount(String condition, String keyword) {
        return inquiryDaoHO.getTotalCount(condition, keyword);
    }

	public Inquiry InquiryListDetail(long inquiryId) {
		return inquiryDaoHO.InquiryListDetail(inquiryId);
	}

	public int InquiryEdit(
	        Inquiry inquiry,
	        MultipartFile uploadFile) {

	    int result =
	        inquiryDaoHO.InquiryEdit(inquiry);

	    if(result > 0
	       && uploadFile != null
	       && !uploadFile.isEmpty()) {

	        String originalName =
	                uploadFile.getOriginalFilename();

	        String storedName =
	                UUID.randomUUID()
	                + "_"
	                + originalName;

	        String savePath =
	                "C:/upload/inquiry/";

	        File dir =
	                new File(savePath);

	        if(!dir.exists()) {
	            dir.mkdirs();
	        }

	        try {

	            uploadFile.transferTo(
	                new File(
	                    savePath + storedName
	                )
	            );

	            InquiryFile file =
	                    new InquiryFile();

	            file.setInquiryId(
	                    inquiry.getInquiryId());

	            file.setOriginalName(
	                    originalName);

	            file.setStoredName(
	                    storedName);

	            file.setStoragePath(
	                    savePath);

	            file.setAttachTarget(
	                    "A");

	            inquiryDaoHO
	                .insertInquiryFile(file);

	        } catch(Exception e) {

	            e.printStackTrace();
	        }
	    }

	    return result;
	}

	public int InquiryDelete(long inquiryId) {
		return inquiryDaoHO.inquiryDelete(inquiryId);
	}
	
}
