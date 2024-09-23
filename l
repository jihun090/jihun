#include <stdio.h>

#define PRODUCT_COUNT 5

typedef struct {
    char name[20];
    int stock;
    int sold;
} Product;

void restock(Product *p) {
    int quantity;
    printf("%s 입고 수량 입력: ", p->name);
    scanf("%d", &quantity);
    p->stock += quantity;
}

void sell(Product *p) {
    int quantity;
    printf("%s 판매 수량 입력: ", p->name);
    scanf("%d", &quantity);
    if (quantity <= p->stock) {
        p->stock -= quantity;
        p->sold += quantity;
    } else {
        printf("재고 부족!\n");
    }
}

void displayStatus(Product products[]) {
    int totalSold = 0;
    int totalRestocked = 0;
    int maxSoldIndex = 0;
    int minSoldIndex = 0;

    for (int i = 0; i < PRODUCT_COUNT; i++) {
        totalSold += products[i].sold;
        totalRestocked += products[i].stock;
        printf("상품: %s, 재고: %d, 판매량: %d\n", products[i].name, products[i].stock, products[i].sold);

        if (products[i].sold > products[maxSoldIndex].sold) {
            maxSoldIndex = i;
        }
        if (products[i].sold < products[minSoldIndex].sold) {
            minSoldIndex = i;
        }

        if (products[i].stock <= 2) {
            printf("경고: %s 재고가 2 이하입니다!\n", products[i].name);
        }
    }

    printf("전체 판매량: %d\n", totalSold);
    for (int i = 0; i < PRODUCT_COUNT; i++) {
        if (totalRestocked > 0) {
            printf("전체 판매율: %.2f%%\n", (float)products[i].sold / totalRestocked * 100);
        }
    }
    printf("최대 판매량 상품: %s, 판매량: %d\n", products[maxSoldIndex].name, products[maxSoldIndex].sold);
    printf("최소 판매량 상품: %s, 판매량: %d\n", products[minSoldIndex].name, products[minSoldIndex].sold);
}

int main() {
    Product products[PRODUCT_COUNT] = {
        {"상품1", 0, 0}, {"상품2", 0, 0}, {"상품3", 0, 0}, {"상품4", 0, 0}, {"상품5", 0, 0}
    };
    int choice;

    while (1) {
        printf("\n1. 입고\n2. 판매\n3. 상품현황\n4. 프로그램 종료\n선택: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                for (int i = 0; i < PRODUCT_COUNT; i++) {
                    restock(&products[i]);
                }
                break;
            case 2:
                for (int i = 0; i < PRODUCT_COUNT; i++) {
                    sell(&products[i]);
                }
                break;
            case 3:
                displayStatus(products);
                break;
            case 4:
                return 0;
            default:
                printf("잘못된 선택입니다.\n");
        }
    }
}