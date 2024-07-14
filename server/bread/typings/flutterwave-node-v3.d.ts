// declare module 'flutterwave-node-v3' {
//     interface CardPayload {
//         card_number: string;
//         cvv: string;
//         expiry_month: string;
//         expiry_year: string;
//         currency: string;
//         amount: string;
//         redirect_url: string;
//         fullname: string;
//         email: string;
//         phone_number: string;
//         enckey: string;
//         tx_ref: string;
//         authorization?: {
//             mode: string;
//             fields?: string[];
//             pin?: string;
//         };
//         id?: string;
//     }

//     interface Authorization {
//         mode: string;
//         redirect?: string;
//         validate_instructions?: string;
//     }

//     interface CardResponseData {
//         id: string;
//         flw_ref: string;
//         tx_ref: string;
//         status: string;
//         auth_model: string;
//         currency: string;
//         charged_amount: number;
//         app_fee: number;
//         merchant_fee: number;
//         processor_response: string;
//     }

//     interface CardResponse {
//         status: string;
//         message: string;
//         data: CardResponseData;
//         meta: {
//             authorization: Authorization;
//         };
//     }

//     interface ValidatePayload {
//         otp: string;
//         flw_ref: string;
//         type?: string;
//     }

//     interface ValidateResponse {
//         status: string;
//         message: string;
//         data: {
//             id: number;
//             tx_ref: string;
//             flw_ref: string;
//             device_fingerprint: string;
//             amount: number;
//             charged_amount: number;
//             app_fee: number;
//             merchant_fee: number;
//             processor_response: string;
//             auth_model: string;
//             currency: string;
//             ip: string;
//             narration: string;
//             status: string;
//             payment_type: string;
//             created_at: string;
//             account_id: number;
//             customer: {
//                 id: number;
//                 name: string;
//                 phone_number: string;
//                 email: string;
//                 created_at: string;
//             };
//         };
//     }

//     class Flutterwave {
//         constructor(publicKey: string, secretKey: string);

//         Charge: {
//             card(payload: CardPayload): Promise<CardResponse>;
//             validate(payload: ValidatePayload): Promise<ValidateResponse>;
//         };

//         // Add other methods here if needed
//         // Example:
//         // Transfer: {
//         //   initiate(payload: TransferPayload): Promise<TransferResponse>;
//         //   // Other transfer-related methods
//         // };
//     }

//     export = Flutterwave;
// }
