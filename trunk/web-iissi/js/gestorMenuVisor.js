function UpdateCartQuantity() {
    document.cart_quantity.submit();
}

function changeQuantity(qty) {
    document.cart_quantity['quantity'].value = Number(document.cart_quantity['quantity'].value)+Number(qty);
    UpdateCartQuantity();
}
