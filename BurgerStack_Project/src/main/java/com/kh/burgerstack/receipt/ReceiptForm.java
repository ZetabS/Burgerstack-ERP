package com.kh.burgerstack.receipt;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReceiptForm {

    private String receiptMemo;
    private List<ReceiptItem> items;
}