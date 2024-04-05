
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
}