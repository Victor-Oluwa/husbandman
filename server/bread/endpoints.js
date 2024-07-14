
module.exports = {
    //Auth
    BUYER_SIGNUP: '/buyer/sign-up',
    FARMER_SIGNUP: '/farmer/sign-up',
    AUTHENTICATE_RESET_PASSWORD_TOKEN: '/admin/password/token/send',
    RESET_PASSWORD: '/user/password/reset',
    SEND_RESET_PASSWORD_TOKEN: '/admin/password/reset/send-token',
    SIGN_IN: '/user/sign-in',
    UPDATE_USER: '/user/update-info',
    VALIDATE_USER: '/admin/validate-user',
    VALIDATE_FARMER_INVITATION_KEY: '/admin/farmer-key/validate',

    // Admin
    BLOCK_USER: '/admin/block-user',
    CHANGE_FARMER_BADGE: '/admin/farmer/change-badge',
    DELETE_ACCOUNT: '/admin/delete-account',
    FETCH_ALL_ORDERS: '/admin/fetch-all-orders',
    FETCH_ALL_INVITATION_TOKEN: '/admin/fetch-all-invitation-token',
    FETCH_ALL_USERS: '/admin/fetch-all-users',
    FILTER_USER: '/admin/filter-user',
    SEARCH_USER: '/admin/generate-invitation-token',
    SAVE_INVITATION_TOKEN: '/admin/save-token',

    // Product Manager
    UPLOAD_PRODUCT: '/product/upload',
    DELETE_PRODUCT: '/farmer/product/delete',
    FETCH_SELLER_PRODUCT: '/farmer/products',
    GET_IMAGE_URL: '/product/image-url',
    LIKE_PRODUCT: '/product/like',
    RATE_PRODUCT: '/product/rate',
    SEARCH_PRODUCT: '/product/search',
    UPDATE_PRODUCT: '/product/update',
    FETCH_ALL_PRODUCTS: '/product/all',
    FETCH_PRODUCT_BY_CATEGORY: '/product/category',
    ADD_PRODUCT_TO_CART: '/product/add-to-cart',

    //Cart
    FETCH_CART: '/cart/fetch-all',
    UPDATE_ITEM_QUANTITY: '/cart/update',
    DELETE_CART_ITEM: '/cart/items/deleteOne',
    DELETE_CART: '/cart/delete',

    //Payment
    ADD_NEW_CARD_ENDPOINT: '/card/add-new',
    DELETE_CARD_ENDPOINT: '/card/delete',
    FETCH_ALL_CARDS_ENDPOINT: '/cards/fetch-all',
    INITIALIZE_CARD_FUNDING: '/card/fund/initialise',
    CARD_FUNDING_PIN_AUTH: '/card/authorize-pin',
    CARD_FUNDING_ADDRESS_AUTH: '/card/authorize-address',
    CARD_FUNDING_VERIFICATION: '/card/funding/verify',

}







