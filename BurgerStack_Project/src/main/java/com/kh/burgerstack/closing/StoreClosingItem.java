package com.kh.burgerstack.closing;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class StoreClosingItem {

    private Long storeClosingItemId;
    private Long storeClosingId;
    private Long materialId;
    private Long systemQuantity;
    private Long physicalQuantity;
    private Long disposalQuantity;
    private Long differenceQuantity;
    private String closingItemMemo;
}
