package com.kh.burgerstack.file;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FileService {
    private final FileDao fileDao;
    private final FileStore fileStore;

    public StoredFile storeFile(MultipartFile file, long uploaderId) {
        StoredFile storedFile = fileStore.store(file, uploaderId);

        try {
            return fileDao.save(storedFile);
        } catch (Exception e) {
            fileStore.delete(storedFile);
            throw new FileException("파일 저장에 실패했습니다.");
        }
    }

    public StoredFile findFile(long fileId) {
        StoredFile storedFile = fileDao.findById(fileId).orElseThrow(() -> new FileException("파일을 찾을 수 없습니다."));
        return storedFile;
    }

    public FileResource loadFile(long fileId) {
        StoredFile storedFile = findFile(fileId);
        FileResource fileResource = FileResource.fromStoredFile(storedFile);
        return fileResource;
    }

    public void deleteFile(long fileId) {
        boolean success = fileDao.markDeleted(fileId);
        if (!success) {
            throw new FileException("삭제할 파일을 찾을 수 없습니다.");
        }
    }
}
