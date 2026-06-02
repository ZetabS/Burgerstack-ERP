package com.kh.burgerstack.file;

import com.kh.burgerstack.exception.CustomException;

public class FileStoreException extends CustomException {
    public FileStoreException(String message) {
        super(message);
    }
}
